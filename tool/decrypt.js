const fs = require('fs')
const path = require('path')
const crypto = require('crypto')

// Offline helper for AI agents/maintainers to inspect encrypted DC_ENC_v1 mods.
// It is intentionally not part of the browser runtime.
const ENCRYPT_SIG = 'DC_ENC_v1'

// 解析 ASAR 文件头，返回 { files: Map<路径, {offset,size}>, dataOffset }
function parseAsar(buffer) {
  // Electron ASAR 格式：
  //   [4 bytes] pickHeaderSize (通常 4 或 16)
  //   [4 bytes] header total size (包含 JSON 后的 padding)
  //   之后就是 JSON header
  // 直接搜索 {"files" 来找 JSON 起始
  // 直接找第一个 { 然后验证后面是不是 "files"
  const view = buffer
  let bracePos = -1
  for (let i = 0; i < 2048 && i < view.length; i++) {
    if (view[i] === 0x7b) {
      // 检查是不是 {"files"
      if (i + 7 < view.length && view[i+1] === 0x22 && view[i+2] === 0x66 &&
          view[i+3] === 0x69 && view[i+4] === 0x6c && view[i+5] === 0x65 &&
          view[i+6] === 0x73 && view[i+7] === 0x22) {
        bracePos = i
        break
      }
    }
  }
  if (bracePos === -1) throw new Error('ASAR header JSON not found')
  let depth = 0, endPos = -1
  for (let i = bracePos; i < view.length; i++) {
    if (view[i] === 0x7b) depth++
    if (view[i] === 0x7d) { depth--; if (depth === 0) { endPos = i; break } }
  }
  if (endPos === -1) throw new Error('ASAR header JSON incomplete')

  // 使用 slice 而非 new Uint8Array(buffer, offset, length)
  // 因为 Node.js Buffer 不是 ArrayBuffer
  const jsonSlice = buffer.slice(bracePos, endPos + 1)
  const headerJson = jsonSlice.toString('utf8')
  const header = JSON.parse(headerJson)

  // data section starts after JSON end + padding
  let dataOffset = endPos + 1
  while (dataOffset < view.length && (view[dataOffset] === 0x00 || view[dataOffset] === 0x0a || view[dataOffset] === 0x0d)) {
    dataOffset++
  }

  const files = new Map()
  function walk(tree, prefix) {
    if (!tree || !tree.files) return
    for (const name in tree.files) {
      const entry = tree.files[name]
      const p = prefix ? prefix + '/' + name : name
      if (entry.files) walk(entry, p)
      else if (entry.offset !== undefined && entry.size !== undefined) {
        files.set(p, { offset: parseInt(entry.offset, 10), size: parseInt(entry.size, 10) })
      }
    }
  }
  walk(header, '')
  return { files, dataOffset, buffer }
}

// 从 ASAR 中读取文件内容
function readFile(asar, filePath) {
  const entry = asar.files.get(filePath)
  if (!entry) return null
  return asar.buffer.slice(asar.dataOffset + entry.offset, asar.dataOffset + entry.offset + entry.size)
}

// 还原私钥（PRIVATE_KEY_B64 的 base64 正文是反转的）
function deobfuscateKey(fakeKey) {
  if (!fakeKey) return null
  let content = fakeKey
    .replace('-----BEGIN RSA PRIVATE KEY-----', '')
    .replace('-----END RSA PRIVATE KEY-----', '').trim()
  // 反转 base64 字符串
  const b64 = content.split('').reverse().join('')
  const lines = b64.match(/.{1,64}/g)
  if (!lines) return null
  return `-----BEGIN RSA PRIVATE KEY-----\n${lines.join('\n')}\n-----END RSA PRIVATE KEY-----`
}

// 解密 DC_ENC_v1 格式的内容
function decryptContent(buffer, privateKey) {
  if (!buffer || buffer.length < ENCRYPT_SIG.length + 4) return null
  if (buffer.slice(0, ENCRYPT_SIG.length).toString() !== ENCRYPT_SIG) return null

  const keyLen = buffer.readUInt32BE(ENCRYPT_SIG.length)
  if (buffer.length < ENCRYPT_SIG.length + 4 + keyLen) return null

  const encKey = buffer.slice(ENCRYPT_SIG.length + 4, ENCRYPT_SIG.length + 4 + keyLen)
  const info = crypto.privateDecrypt(
    { key: privateKey, padding: crypto.constants.RSA_PKCS1_OAEP_PADDING },
    encKey
  )
  const aesKey = info.slice(0, 32)
  const iv = info.slice(32, 48)
  const cipher = buffer.slice(ENCRYPT_SIG.length + 4 + keyLen)

  const decipher = crypto.createDecipheriv('aes-256-cbc', aesKey, iv)
  return Buffer.concat([decipher.update(cipher), decipher.final()])
}

// ----- 主流程 -----

const args = process.argv.slice(2)
if (args.length < 1) {
  console.error('用法: node decrypt.js <asar文件路径> [输出目录]')
  process.exit(1)
}

const asarPath = path.resolve(args[0])
const outDir = args[1] ? path.resolve(args[1]) : path.join(path.dirname(asarPath), path.basename(asarPath, '.asar') + '_decrypted')

if (!fs.existsSync(asarPath)) {
  console.error('文件不存在:', asarPath)
  process.exit(1)
}

console.log('ASAR 文件:', asarPath)
console.log('输出目录:', outDir)

const buffer = fs.readFileSync(asarPath)
const asar = parseAsar(buffer)
console.log(`解析完成: ${asar.files.size} 个文件, dataOffset=${asar.dataOffset}`)

// 读取 .env
const envRaw = readFile(asar, '.env')
if (!envRaw) {
  console.error('未找到 .env 文件，模组未加密或格式不对')
  process.exit(1)
}

const envText = envRaw.toString('utf8')
console.log('\n=== .env ===')
console.log(envText)

// 解析 .env
const env = {}
envText.split(/\r?\n/).forEach(line => {
  const t = line.trim()
  if (!t || t.startsWith('#')) return
  const i = t.indexOf('=')
  if (i === -1) return
  env[t.slice(0, i).trim()] = t.slice(i + 1).trim()
})

// 还原私钥
const privateKeyPem = deobfuscateKey(env.PRIVATE_KEY_B64)
if (!privateKeyPem) {
  console.error('私钥还原失败')
  process.exit(1)
}
console.log('\n=== RSA 私钥 ===')
console.log(privateKeyPem)

// 过滤规则
const whiteList = (env.ENCRYPT_WHITELIST || '').split(',').filter(Boolean).map(s => new RegExp(s.trim(), 'i'))
const blackList = (env.ENCRYPT_BLACKLIST || '').split(',').filter(Boolean).map(s => new RegExp(s.trim(), 'i'))

function shouldDecrypt(fileName) {
  for (const re of blackList) if (re.test(fileName)) return false
  if (whiteList.length > 0) return whiteList.some(re => re.test(fileName))
  return true
}

// 创建输出目录
fs.mkdirSync(outDir, { recursive: true })

// 提取并解密所有文件
let decryptedCount = 0
let plainCount = 0

asar.files.forEach((info, filePath) => {
  const data = readFile(asar, filePath)
  if (!data) {
    console.warn(`  跳过(读取失败): ${filePath}`)
    return
  }

  const fileName = path.basename(filePath)
  const outPath = path.join(outDir, filePath)
  fs.mkdirSync(path.dirname(outPath), { recursive: true })

  if (shouldDecrypt(fileName) && data.slice(0, ENCRYPT_SIG.length).toString() === ENCRYPT_SIG) {
    try {
      const decrypted = decryptContent(data, privateKeyPem)
      if (decrypted) {
        fs.writeFileSync(outPath, decrypted)
        console.log(`  [解密] ${filePath} (${data.length}B → ${decrypted.length}B)`)
        decryptedCount++
        return
      }
    } catch (e) {
      console.warn(`  解密失败 ${filePath}: ${e.message}`)
    }
  }

  // 不解密：直接复制
  fs.writeFileSync(outPath, data)
  plainCount++
  if (!filePath.startsWith('.')) {
    console.log(`  [复制] ${filePath} (${data.length}B)`)
  }
})

console.log(`\n完成: ${decryptedCount} 个解密, ${plainCount} 个直接复制`)
console.log('输出路径:', outDir)
