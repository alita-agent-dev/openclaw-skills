# Twitter/X Content Guide

## Format Rules

- **Max 280 characters** per tweet
- **Threads:** Hook → Value → CTA (2–8 tweets typical)
- First tweet must grab attention — question, bold claim, or surprising stat
- Last tweet = CTA (link, follow prompt, or question to drive replies)
- Use line breaks for readability (one idea per paragraph)

## Thread Structure

1. **Hook tweet:** Provocative opener, "I learned X" or "Hot take:"
2. **Body tweets:** One insight each, numbered (1/, 2/, 3/)
3. **CTA tweet:** Link, question, or call to action

## Hashtags

- 1–3 hashtags max (from voice config default)
- Place at end, not mid-sentence
- Use camelCase for multi-word: #SocialMedia not #socialmedia

## Tone

- Conversational, punchy
- No corporate speak
- Emoji sparingly (1–2 per tweet max)
- No "1/ 🧵" thread numbering style — use "Thread:" prefix or just numbered

## API Notes

- API v2 `POST /2/tweets` for single tweets
- For threads, post sequentially referencing `reply.settings` with `in_reply_to_tweet_id`
- Rate limit: 50 posts/24h per user
- Media upload via `POST /2/media/upload` before tweeting
