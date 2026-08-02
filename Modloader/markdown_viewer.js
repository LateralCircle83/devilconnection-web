// Local, safe-enough Markdown renderer for the manager About page.
// It supports the README patterns used by this project and escapes raw HTML.
(function(global) {
  'use strict'

  function escapeHtml(value) {
    return String(value == null ? '' : value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')
  }

  function escapeAttr(value) {
    return escapeHtml(value).replace(/`/g, '&#96;')
  }

  function safeHref(href) {
    var raw = String(href || '').trim()
    if (!raw) return ''
    var lower = raw.toLowerCase()
    if (lower.indexOf('javascript:') === 0 || lower.indexOf('data:') === 0) return ''
    return raw
  }

  function renderInline(text) {
    var tokens = []

    function token(html) {
      tokens.push(html)
      return '\u0000' + (tokens.length - 1) + '\u0000'
    }

    function resolveTokens(value) {
      var current = value
      var previous = ''
      var guard = 0
      while (current !== previous && guard < 10) {
        previous = current
        current = current.replace(/\u0000(\d+)\u0000/g, function(match, index) {
          return tokens[Number(index)] || ''
        })
        guard++
      }
      return current
    }

    var source = String(text == null ? '' : text)
    source = source.replace(/`([^`]+)`/g, function(match, code) {
      return token('<code>' + escapeHtml(code) + '</code>')
    })
    source = source.replace(/!\[([^\]]*)\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g, function(match, alt, href) {
      var safe = safeHref(href)
      var label = escapeHtml(alt || href)
      if (!safe) return label
      return token('<a href="' + escapeAttr(safe) + '" target="_blank" rel="noopener noreferrer">' + label + '</a>')
    })
    source = source.replace(/\[([^\]]+)\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g, function(match, label, href) {
      var safe = safeHref(href)
      var text = escapeHtml(label)
      if (!safe) return text
      return token('<a href="' + escapeAttr(safe) + '" target="_blank" rel="noopener noreferrer">' + text + '</a>')
    })

    var html = escapeHtml(source)
    html = html.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    html = html.replace(/__([^_]+)__/g, '<strong>$1</strong>')
    html = html.replace(/\*([^*\s][^*]*?)\*/g, '<em>$1</em>')
    html = html.replace(/_([^_\s][^_]*?)_/g, '<em>$1</em>')
    return resolveTokens(html)
  }

  function isBlockStart(line) {
    return /^(#{1,6})\s+/.test(line) ||
      /^\s*(```|~~~)/.test(line) ||
      /^\s*(?:[-*_]\s*){3,}$/.test(line) ||
      /^\s*>\s?/.test(line) ||
      /^\s*[-*+]\s+/.test(line) ||
      /^\s*\d+[.)]\s+/.test(line)
  }

  function renderList(lines, index, ordered) {
    var tag = ordered ? 'ol' : 'ul'
    var html = ['<' + tag + '>']
    var pattern = ordered ? /^\s*\d+[.)]\s+/ : /^\s*[-*+]\s+/
    while (index < lines.length && pattern.test(lines[index])) {
      html.push('<li>' + renderInline(lines[index].replace(pattern, '')) + '</li>')
      index++
    }
    html.push('</' + tag + '>')
    return { html: html.join(''), index: index }
  }

  function renderMarkdown(markdown) {
    var lines = String(markdown == null ? '' : markdown).replace(/\r\n?/g, '\n').split('\n')
    var html = []
    var i = 0

    while (i < lines.length) {
      var line = lines[i]
      if (/^\s*$/.test(line)) {
        i++
        continue
      }

      var fence = line.match(/^\s*(```|~~~)\s*([A-Za-z0-9_-]+)?\s*$/)
      if (fence) {
        var lang = fence[2] ? ' class="language-' + escapeAttr(fence[2]) + '"' : ''
        var code = []
        i++
        while (i < lines.length && !new RegExp('^\\s*' + fence[1]).test(lines[i])) {
          code.push(lines[i])
          i++
        }
        if (i < lines.length) i++
        html.push('<pre><code' + lang + '>' + escapeHtml(code.join('\n')) + '</code></pre>')
        continue
      }

      var heading = line.match(/^(#{1,6})\s+(.+?)\s*#*\s*$/)
      if (heading) {
        var level = heading[1].length
        html.push('<h' + level + '>' + renderInline(heading[2]) + '</h' + level + '>')
        i++
        continue
      }

      if (/^\s*(?:[-*_]\s*){3,}$/.test(line)) {
        html.push('<hr>')
        i++
        continue
      }

      if (/^\s*>\s?/.test(line)) {
        var quote = []
        while (i < lines.length && /^\s*>\s?/.test(lines[i])) {
          quote.push(lines[i].replace(/^\s*>\s?/, ''))
          i++
        }
        html.push('<blockquote>' + renderMarkdown(quote.join('\n')) + '</blockquote>')
        continue
      }

      if (/^\s*[-*+]\s+/.test(line)) {
        var unordered = renderList(lines, i, false)
        html.push(unordered.html)
        i = unordered.index
        continue
      }

      if (/^\s*\d+[.)]\s+/.test(line)) {
        var ordered = renderList(lines, i, true)
        html.push(ordered.html)
        i = ordered.index
        continue
      }

      var para = [line.trim()]
      i++
      while (i < lines.length && !/^\s*$/.test(lines[i]) && !isBlockStart(lines[i])) {
        para.push(lines[i].trim())
        i++
      }
      html.push('<p>' + renderInline(para.join(' ')) + '</p>')
    }

    return html.join('\n')
  }

  function loadMarkdownElement(el) {
    var source = el && el.getAttribute ? el.getAttribute('data-markdown-source') : ''
    if (!source || typeof fetch !== 'function') return

    var fallback = el.innerHTML
    el.setAttribute('data-markdown-state', 'loading')
    fetch(source, { cache: 'no-cache' }).then(function(response) {
      if (!response.ok) throw new Error('HTTP ' + response.status)
      return response.text()
    }).then(function(markdown) {
      el.innerHTML = renderMarkdown(markdown)
      el.setAttribute('data-markdown-state', 'loaded')
    }).catch(function(error) {
      console.warn('MarkdownViewer: failed to load ' + source, error)
      el.innerHTML = fallback
      el.setAttribute('data-markdown-state', 'fallback')
    })
  }

  function hydrate(root) {
    if (!root || !root.querySelectorAll) return
    var nodes = root.querySelectorAll('[data-markdown-source]')
    for (var i = 0; i < nodes.length; i++) loadMarkdownElement(nodes[i])
  }

  global.ManagerMarkdown = {
    render: renderMarkdown,
    hydrate: hydrate,
  }

  if (global.document) {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', function() { hydrate(document) })
    } else {
      hydrate(document)
    }
  }
})(typeof window !== 'undefined' ? window : globalThis)
