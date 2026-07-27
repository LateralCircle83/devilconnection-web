import { readFileSync, writeFileSync, statSync, readdirSync, openSync, writeSync, closeSync } from 'fs'
import { join } from 'path'

const [dir, out] = [process.argv[2], process.argv[3]].map(p => join(process.cwd(), p))
const files = []
function walk(d, p) {
  for (const n of readdirSync(d)) {
    const f = join(d, n), r = p ? p + '/' + n : n
    if (statSync(f).isDirectory()) walk(f, r)
    else files.push({ path: r, file: f })
  }
}
walk(dir, '')
files.sort((a, b) => a.path.localeCompare(b.path))

let off = 0
const ents = {}
for (const f of files) {
  const s = statSync(f.file).size, parts = f.path.split('/')
  let n = ents
  for (let i = 0; i < parts.length; i++) {
    if (i === parts.length - 1) n[parts[i]] = { size: s, offset: String(off) }
    else { if (!n[parts[i]]) n[parts[i]] = { files: {} }; n = n[parts[i]].files }
  }
  off += s
}

const json = JSON.stringify({ files: ents })
const jbuf = Buffer.from(json, 'utf8')
const ps = Math.ceil((16 + jbuf.length) / 4) * 4
const h = Buffer.alloc(ps, 0)
h.writeUInt32LE(4, 0); h.writeUInt32LE(ps, 4); h.writeUInt32LE(jbuf.length + 8, 8); h.writeUInt32LE(jbuf.length, 12)
jbuf.copy(h, 16)
const fd = openSync(out, 'w')
writeSync(fd, h)
for (const f of files) writeSync(fd, readFileSync(f.file))
closeSync(fd)
console.log('packed', files.length, 'files')
