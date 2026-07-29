import { readFileSync } from 'fs'
const html = readFileSync('D:/devilconnection-web/index.html', 'utf8')
const css = readFileSync('D:/devilconnection-web/Modloader/manager.css', 'utf8')
const classes = [...html.matchAll(/class="([^"]+)"/g)].map(m => m[1])
let missing = 0
for (const cls of classes) {
  const names = cls.split(/\s+/)
  for (const name of names) {
    const pattern = '.' + name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
    if (!new RegExp(pattern + '[\\s{]').test(css)) {
      console.log('❌ CSS missing: .' + name)
      missing++
    }
  }
}
if (missing === 0) console.log('✅ All CSS classes found')
