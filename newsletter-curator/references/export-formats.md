# Export Formats

## Markdown (Default)

Save the drafted newsletter as-is to `newsletters/YYYY-MM-DD-{style}.md`. No transformation needed.

## HTML Email

Wrap the newsletter in a responsive, inline-styled HTML template:

- Max width 600px, centered
- Sans-serif font stack (system fonts)
- Inline CSS only (email client compatibility)
- Section headers styled as colored blocks
- Links as full URLs (not just anchor text) for plain-text fallback
- Images: use `alt` text, max-width 100%

Key structure:
```html
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;background:#f4f4f4;font-family:...;">
  <table role="presentation" width="100%" ...>
    <!-- Header -->
    <!-- Content rows -->
    <!-- Footer with unsubscribe placeholder -->
  </table>
</body>
</html>
```

Save to `newsletters/YYYY-MM-DD-{style}.html`.

## Substack

Generate a clean markdown file optimized for Substack's editor:

- Use `##` for section headers (Substack maps these to headings)
- Use **bold** for item titles, not headings
- Keep links as `[text](url)` — Substack converts on paste
- Use `***` for horizontal rules between sections
- Include a suggested subtitle line at the top as a blockquote
- No raw HTML

```markdown
> {suggested subtitle/tagline}

***

## ⭐ Featured
...content...

***

## 🔗 Quick Links
...content...

***

*Subscribe for next week's digest →*
```

Save to `newsletters/YYYY-MM-DD-{style}-substack.md`.
