---
name: social-media-scheduler
description: >
  Create, schedule, and manage social media content across platforms.
  Takes one piece of source content and generates platform-specific versions
  (Twitter/X thread, LinkedIn post, Instagram caption, newsletter blurb).
  Schedules via Twitter API v2 and LinkedIn API. Maintains a content calendar
  and tracks engagement metrics. Supports voice/theme configuration.
  Triggers on: social media post, schedule tweet, content calendar, LinkedIn post,
  Instagram caption, newsletter blurb, engagement metrics, social media strategy.
version: 1.0.0
metadata:
  openclaw:
    emoji: "📅"
    homepage: https://github.com/openclaw/skills/social-media-scheduler
    requires:
      bins:
        - jq
      env:
        - TWITTER_API_KEY
        - TWITTER_API_SECRET
        - TWITTER_ACCESS_TOKEN
        - TWITTER_ACCESS_SECRET
        - LINKEDIN_ACCESS_TOKEN
---

# Social Media Scheduler

## Overview

Generate platform-tailored content from a single source, schedule it, and track performance.

## Quick Start

1. **Configure voice** → edit `calendar.json` voice config (or let it default)
2. **Create content** → provide source material (URL, text, bullet points)
3. **Generate variants** → agent produces platform-specific versions
4. **Schedule** → posts land in the content calendar and are published at scheduled times
5. **Track** → engagement metrics pulled and stored per post

## Content Calendar

All state lives in a single JSON file. Default location:

```
~/.openclaw/workspace/data/social-calendar.json
```

### Structure

```json
{
  "voice": {
    "tone": "professional yet approachable",
    "personality": ["witty", "knowledgeable", "concise"],
    "forbidden": ["corporate jargon", "cringe hashtags"],
    "default_hashtags": { "twitter": 3, "linkedin": 2, "instagram": 10 }
  },
  "posts": [
    {
      "id": "uuid",
      "source": "original content or URL",
      "platform": "twitter|linkedin|instagram|newsletter",
      "content": "generated text",
      "thread": ["tweet 1", "tweet 2"],
      "status": "draft|scheduled|published|failed",
      "scheduled_at": "ISO-8601",
      "published_at": "ISO-8601",
      "metrics": { "likes": 0, "shares": 0, "comments": 0, "impressions": 0 },
      "tags": ["theme1", "theme2"]
    }
  ],
  "themes": ["product", "engineering", "thought-leadership"]
}
```

Initialize with: `cat references/calendar-template.json` and adapt.

## Workflow

### 1. Generate Content Variants

Given source material, produce four variants following platform guides:

| Platform | Guide |
|----------|-------|
| Twitter/X | `references/twitter-guide.md` |
| LinkedIn | `references/linkedin-guide.md` |
| Instagram | `references/instagram-guide.md` |
| Newsletter | `references/newsletter-guide.md` |

Rules:
- Respect voice config from calendar
- Each variant must feel native to its platform (not copy-pasted)
- Include relevant hashtags per platform defaults
- Twitter: split into thread if >280 chars, hook in first tweet, CTA in last

### 2. Schedule & Publish

Use platform APIs via `exec`:

**Twitter (API v2):**
```bash
# Post tweet
curl -s -X POST "https://api.twitter.com/2/tweets" \
  -H "Authorization: Bearer $TWITTER_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"text": "..."}'
```

**LinkedIn (UGC API):**
```bash
curl -s -X POST "https://api.linkedin.com/v2/ugcPosts" \
  -H "Authorization: Bearer $LINKEDIN_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d @linkedin-post.json
```

After successful publish, update calendar entry status to `published` and set `published_at`.

### 3. Track Metrics

For published posts, periodically fetch engagement:

- **Twitter:** `GET https://api.twitter.com/2/tweets/{id}?tweet.fields=public_metrics`
- **LinkedIn:** `GET https://api.linkedin.com/v2/socialActions/{urn}`

Update `metrics` in calendar. Report trends when asked.

## Scheduling Logic

- Default: space posts 1–2 hours apart across platforms
- Same content goes to different platforms at different times to maximize reach
- Never schedule more than 3 posts/day per platform without explicit approval
- Avoid 23:00–07:00 UTC unless user specifies timezone preferences

## Commands

| User says | Action |
|-----------|--------|
| "post about X" | Generate variants, show for approval, add to calendar |
| "schedule for [date/time]" | Set scheduled_at, queue for publishing |
| "publish now" | Immediately push to platform API |
| "content calendar" | Show upcoming scheduled posts |
| "engagement report" | Pull metrics, summarize |
| "change voice to X" | Update voice config |
| "reschedule [id] to [time]" | Move scheduled post |

## File Reference

| File | Purpose |
|------|---------|
| `references/twitter-guide.md` | Twitter/X formatting, thread rules, hooks |
| `references/linkedin-guide.md` | LinkedIn post structure, formatting |
| `references/instagram-guide.md` | Instagram caption style, hashtag strategy |
| `references/newsletter-guide.md` | Newsletter blurb format, CTA patterns |
| `references/calendar-template.json` | Blank calendar template |
