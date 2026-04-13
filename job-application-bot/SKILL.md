---
name: job-application-bot
description: >
  Automate job applications — parse resumes, match jobs, generate cover letters,
  track applications, send follow-up reminders. Triggers on: job search, apply for jobs,
  resume parsing, cover letter generation, application tracking, follow-up reminder,
  job application bot.
version: 1.0.0
metadata:
  openclaw:
    emoji: "💼"
    homepage: ""
    requires:
      - web_search
      - pdf (optional)
---

# Job Application Bot

Automates the job application pipeline: resume parsing → job matching → cover letters → tracking → follow-ups.

## Quick Start

1. **Parse resume:** `parse resume at /path/to/resume.pdf` — extracts skills, experience, education into a structured profile.
2. **Find jobs:** `search jobs for frontend developer in Berlin, remote, €60k+` — returns matching listings.
3. **Apply:** `apply to [job]` — generates a tailored cover letter and logs the application.
4. **Track:** `show my applications` — lists all applications and statuses.
5. **Follow up:** `follow up on [company]` — drafts a follow-up email or reminder.

## Resume Parsing

- Accept PDF or plain text via `pdf` tool or `read` tool.
- Extract: name, contact info, skills (technical + soft), work history (company, title, dates, highlights), education (degree, school, year).
- Store parsed profile in `~/.openclaw/workspace/job-apps/profile.json`.
- If parsing fails, ask the user to paste key details.

## Job Search & Matching

- Use `web_search` with user criteria: role, location, salary range, remote preference, keywords.
- Compare job requirements against parsed resume profile — score matches on skills overlap, experience level, location fit.
- Present top matches with: title, company, location, salary (if listed), match score, apply link.
- User confirms before any application is logged.

## Cover Letter Generation

- For each application, generate a tailored cover letter using:
  - Resume profile (skills, experience highlights)
  - Job description details
  - Company name and role title
- Output format: professional, concise (250–350 words), no filler.
- Save to `~/.openclaw/workspace/job-apps/cover-letters/{company}-{role}.txt`.

## Application Tracking

- Maintain tracker at `~/.openclaw/workspace/job-apps/applications.json`:
  ```json
  [
    {
      "id": "unique-id",
      "company": "Acme Corp",
      "role": "Frontend Developer",
      "url": "https://...",
      "dateApplied": "2025-01-15",
      "status": "applied|interview|offer|rejected|withdrawn",
      "coverLetter": "cover-letters/acme-frontend.txt",
      "followUpDates": ["2025-01-22"],
      "notes": ""
    }
  ]
  ```
- Support commands: `add application`, `update status [id] to interview`, `show applications`, `show rejected`.
- CSV export: `export applications as csv` → writes `applications.csv` alongside the JSON.

## Follow-Up Reminders

- Default follow-up cadence: 7 days after application, then 14 days.
- `follow up on [company]` — checks tracker, drafts a polite follow-up email.
- `set reminder for [company] in N days` — schedules via HEARTBEAT.md or cron.
- During heartbeats, check `applications.json` for overdue follow-ups and notify the user.

## Data Layout

```
~/.openclaw/workspace/job-apps/
├── profile.json              # Parsed resume
├── applications.json         # Application tracker
├── applications.csv          # Optional CSV export
└── cover-letters/
    └── {company}-{role}.txt  # Generated cover letters
```

## Detailed Reference

- Resume parsing logic and field extraction: see `references/resume-parsing.md`
- Job matching algorithm and scoring: see `references/job-matching.md`
- Cover letter templates and tone: see `references/cover-letters.md`
- Tracker schema and status workflow: see `references/tracking.md`
- Follow-up templates and scheduling: see `references/follow-ups.md`
