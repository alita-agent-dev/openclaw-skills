# Follow-Up Reminders

## Default Cadence

| Timing | Action |
|--------|--------|
| 7 days after `applied` | First follow-up: polite check-in email draft |
| 14 days after first follow-up | Second follow-up if no response |
| After `interview` | Thank-you note within 24h, follow-up after 5 days |

## Follow-Up Email Template

**Subject:** `Following up — {role} application`

**Body:**
```
Hi {hiring_manager or "Hiring Team"},

I wanted to follow up on my application for the {role} position at {company}, submitted on {dateApplied}.

I remain very interested in this opportunity. My experience with {skill_1} and {skill_2} aligns well with what you're looking for, and I'd love the chance to discuss how I can contribute to {company}'s goals.

Is there any update on the hiring timeline? I'm happy to provide any additional information you might need.

Best regards,
{candidate_name}
{email}
```

## Scheduling

### Via HEARTBEAT.md
Add a follow-up check to `HEARTBEAT.md`:
```markdown
- [ ] Check job-apps/applications.json for follow-ups due today
```

### Via Cron
For specific reminders:
```
openclaw cron add --in "7d" --task "Remind George: follow up on {company} {role} application"
```

## Heartbeat Integration

During heartbeats, the agent should:
1. Read `applications.json`.
2. Find entries where `nextFollowUp` ≤ today and `status` is `applied` or `screening`.
3. Notify the user with company name, role, and days since application.
4. Offer to draft a follow-up email.
5. After notification, update `nextFollowUp` to the next cadence date.

## Status-Based Follow-Up Logic

| Status | Follow-up Action |
|--------|-----------------|
| `applied` (7+ days) | Draft check-in email |
| `screening` (7+ days) | Gentle follow-up on timeline |
| `interview` (next day) | Draft thank-you note |
| `interview` (5+ days) | Follow up on next steps |
| `offer` | No auto-follow-up; notify user |
| `rejected` | No follow-up; optionally archive |

## User Preferences

- User can customize cadence: `set follow-up to N days`.
- User can disable auto-reminders: `disable follow-up reminders`.
- User can mark applications as "no follow-up needed" in notes.
