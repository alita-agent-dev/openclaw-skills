---
name: newsletter-curator
description: >
  Create curated newsletters from RSS feeds, saved links, and email forwards.
  Summarize, categorize, and export newsletters in multiple formats.
  Triggers on: newsletter, digest, roundup, curate links, weekly email,
  daily brief, newsletter draft, summarize feed, RSS roundup, Substack draft.
version: 1.0.0
metadata:
  openclaw:
    emoji: "📬"
    homepage: "https://github.com/openclaw/skills/tree/main/newsletter-curator"
---

# Newsletter Curator

## Overview

Aggregate, summarize, and package content into polished newsletter drafts.

## Workflow

1. **Collect** — Gather content from RSS feeds, URLs, pasted text, or email forwards
2. **Summarize** — Generate concise summaries per item
3. **Categorize** — Group by topic (auto-detected or user-specified)
4. **Draft** — Assemble into a newsletter using the appropriate style template
5. **Export** — Output in the requested format

## Commands

When the user asks to create a newsletter, follow this sequence:

### Step 1: Gather Content

Accept input in any of these forms:
- **RSS feeds**: Fetch via `web_fetch` or `exec` with `curl`
- **URLs**: Fetch each URL and extract readable content via `web_fetch`
- **Pasted text**: Use directly
- **Files**: Read from workspace files the user points to

If no sources given, ask for at least one. Store collected items in memory.

### Step 2: Choose Style

Default: `weekly-digest`. Detect from user request or ask.

| Style | Use When |
|---|---|
| `daily-brief` | User says "daily", "today's", "morning brief" |
| `weekly-digest` | User says "weekly", "digest", "this week" |
| `monthly-roundup` | User says "monthly", "roundup", "this month" |

Load the matching template from `references/styles.md`.

### Step 3: Draft the Newsletter

Apply the style template. Rules:
- Write a compelling subject line
- Use the section structure from the template (Featured / Quick Links / Deep Dive)
- Each item gets a title, source attribution, 1-2 sentence summary, and link
- Featured section: top 1-3 items (most impactful/relevant)
- Quick Links: 4-8 items with one-line descriptions
- Deep Dive: 1 item with extended analysis (3-5 paragraphs)
- Add a brief editor's note at the top (2-3 sentences)

### Step 4: Export

Default: `markdown`. Detect from user request or ask.

| Format | Use When |
|---|---|
| `markdown` | Default, or user says "md", "markdown" |
| `html-email` | User says "email", "HTML", "mailchimp" |
| `substack` | User says "substack" |

Load export instructions from `references/export-formats.md`.

### Step 5: Save & Track

- Save draft to `workspace/newsletters/YYYY-MM-DD-{style}.md`
- Update `workspace/newsletters/topics.json` with topic frequencies for future curation
- Track which sources and topics appear most often

## Preferences Tracking

Maintain `newsletters/topics.json`:

```json
{
  "topics": { "AI": 12, "Web Dev": 8 },
  "sources": { "example.com/feed": 5 },
  "styles_used": { "weekly-digest": 10 },
  "last_generated": "2025-01-15"
}
```

Use tracked preferences to auto-prioritize content the user cares about most.

## Notes

- Keep summaries factual; never invent content not in the source
- If a URL fails, skip it and note the failure in the draft
- Respect RSS feed rate limits — don't hammer endpoints
