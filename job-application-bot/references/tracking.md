# Application Tracking

## Tracker Schema (applications.json)

```json
[
  {
    "id": "auto-generated-uuid",
    "company": "Acme Corp",
    "role": "Frontend Developer",
    "url": "https://jobs.acme.com/12345",
    "location": "Berlin (Hybrid)",
    "salary": "€70,000–€85,000",
    "dateApplied": "2025-01-15",
    "status": "applied",
    "matchScore": 0.87,
    "coverLetter": "cover-letters/acme-frontend-developer.txt",
    "followUpDates": ["2025-01-22"],
    "nextFollowUp": "2025-01-22",
    "notes": "Referred by Sarah from engineering",
    "contactEmail": "hr@acme.com",
    "createdAt": "2025-01-15T10:30:00Z",
    "updatedAt": "2025-01-15T10:30:00Z"
  }
]
```

## Status Workflow

```
discovered → applied → screening → interview → offer → accepted
                                    ↘ rejected
                                                         ↘ withdrawn
```

Valid statuses: `discovered`, `applied`, `screening`, `interview`, `offer`, `accepted`, `rejected`, `withdrawn`.

## Commands

| Command | Action |
|---------|--------|
| `add application` | Prompt for details, create new entry |
| `update [id] to [status]` | Change status, log updatedAt |
| `note [id] [text]` | Append to notes field |
| `show applications` | List all with status, date, company |
| `show [status]` | Filter by status (e.g., `show interviews`) |
| `export applications as csv` | Write applications.csv |

## CSV Export Format

```
ID,Company,Role,Location,Salary,Date Applied,Status,Match Score,URL,Notes
```

## Data Management

- File is at `~/.openclaw/workspace/job-apps/applications.json`.
- Initialize with empty array `[]` if file doesn't exist.
- On every write, validate JSON structure.
- Keep entries sorted by `dateApplied` descending.
- Backup before bulk changes (copy to `applications.backup.json`).
