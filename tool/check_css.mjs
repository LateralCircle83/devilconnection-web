import { readFileSync } from 'fs'
import { dirname, join } from 'path'
import { fileURLToPath } from 'url'

const root = join(dirname(fileURLToPath(import.meta.url)), '..')
const html = readFileSync(join(root, 'index.html'), 'utf8')
const css = readFileSync(join(root, 'Modloader', 'manager.css'), 'utf8')
const externalClasses = new Set([
  'remodal',
  'remodal-bg',
  'remodal-cancel',
  'remodal-confirm',
  'remodal-title',
  'remodal-txt',
  'remodal_title',
  'remodal_txt',
  'tyrano_base',
  'vchat_base',
])
const classes = [...html.matchAll(/class="([^"]+)"/g)].map(m => m[1])
let missing = 0
for (const cls of classes) {
  const names = cls.split(/\s+/)
  for (const name of names) {
    if (externalClasses.has(name)) continue
    const pattern = '.' + name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
    if (!new RegExp(pattern + '[\\s{]').test(css)) {
      console.log('CSS missing: .' + name)
      missing++
    }
  }
}
if (missing === 0) console.log('All manager CSS classes found')
