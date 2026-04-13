# Cover Letter Generation

## Principles

- Professional, concise, no filler — 250–350 words.
- Every sentence must add value; cut generic openers like "I am writing to apply for..."
- Tone: confident, specific, slightly enthusiastic without being over the top.

## Structure

1. **Hook (1–2 sentences)**: Reference the role and company with a specific detail showing you researched them.
2. **Value prop (2–3 paragraphs)**: Map 2–3 key achievements from the resume to the job's stated requirements. Use quantified results where possible.
3. **Culture/fit (1–2 sentences)**: Brief alignment with company mission, stack, or values based on available info.
4. **Close (1 sentence)**: Clear call to action — express interest in discussing further.

## Input Sources

- **Profile** (`profile.json`): skills, experience highlights, education.
- **Job description**: extracted from search results or pasted by user.
- **Company info**: quick `web_search` for recent news or mission statement (optional, adds specificity).

## Template Variables

```
{candidate_name}    — from profile
{role}              — from job listing
{company}           — from job listing
{skill_1}, {skill_2} — top matching skills
{achievement_1}     — best quantified achievement relevant to role
{company_detail}    — specific thing about the company
{contact_method}    — email/phone from profile
```

## Customization Per Application

- Never reuse a cover letter verbatim across applications.
- Adjust emphasis based on which skills the job prioritizes.
- If the job emphasizes teamwork, highlight collaborative achievements.
- If the job emphasizes technical depth, highlight specific technical wins.

## Output

- Save to `~/.openclaw/workspace/job-apps/cover-letters/{company}-{role-slug}.txt`.
- Include a subject line: `Application for {role} — {candidate_name}`.
- Always show the generated letter to the user for review before finalizing.

## Anti-patterns to Avoid

- "I am a passionate, hardworking individual..."
- Repeating the resume verbatim.
- Generic company praise without specifics.
- Overly long paragraphs.
- Humor or informality unless the company culture clearly warrants it.
