# LinkedIn Content Guide

## Format Rules

- **Max 3000 characters** per post (700–1300 ideal)
- Hook in first 2 lines (visible before "see more")
- Short paragraphs (1–3 sentences)
- Bullet points for lists
- End with a question or call to action

## Structure

1. **Hook (1–2 lines):** Bold statement, question, or story opener
2. **Context (2–4 paragraphs):** The meat — insights, story, lessons
3. **Takeaway (1–2 lines):** Distilled wisdom
4. **CTA:** "What do you think?" or "Agree?" or link

## Formatting

- Use Unicode bullets (•), not markdown (LinkedIn strips markdown)
- Separate paragraphs with blank lines
- No hashtags in the middle — group at the bottom
- 2–5 hashtags, relevant and specific

## Tone

- Professional but human
- First person, storytelling encouraged
- Avoid buzzwords (leverage, synergy, paradigm)
- Personal experiences > generic advice

## API Notes

- UGC Posts API: `POST https://api.linkedin.com/v2/ugcPosts`
- Requires LinkedIn Developer App with `w_member_social` scope
- Author URN format: `urn:li:person:{id}`
- Images: upload via `POST https://api.linkedin.com/v2/assets?action=registerUpload` first
