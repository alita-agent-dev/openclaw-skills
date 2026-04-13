# Instagram Content Guide

## Caption Rules

- **Max 2200 characters** (125 ideal for above-fold)
- First line = hook (visible without "more")
- Line breaks matter — use them to create visual rhythm
- CTA before hashtags (hashtags push CTA out of view otherwise)

## Structure

1. **Hook (1 line):** Attention-grabbing opener
2. **Body:** Story, insight, or value — broken into short chunks
3. **CTA:** "Save this", "Share with someone who needs this", "Drop a 🔥 if you agree"
4. **Hashtags:** 10–15 relevant tags (up to 30 allowed)

## Hashtag Strategy

- 10–15 hashtags (from voice config, default 10)
- Mix: 40% niche, 40% mid-range, 20% broad
- Place at end or in first comment
- Research and rotate hashtag sets monthly

## Tone

- Casual, authentic, personality-forward
- Emoji-rich but not chaotic (3–5 per caption)
- Inclusive language, community feel
- Stories and vulnerability perform well

## Content Types

- **Carousel:** Educational, step-by-step, listicles
- **Single image:** Quotes, announcements, milestones
- **Reels:** Tips, behind-the-scenes, trending audio

## API Notes

- Instagram Graph API via Facebook Graph API
- `POST /{ig-user-id}/media` to create container, then `POST /{ig-user-id}/media_publish`
- Requires Instagram Business/Creator account
- Caption goes in `caption` parameter
- Hashtag publishing not available via API for personal accounts
