# Job Matching

## Search Strategy

Use `web_search` with constructed queries combining user criteria:

```
{role} jobs {location} {salary} remote:{remote_preference}
```

Search multiple sources: LinkedIn, Indeed, Glassdoor, company career pages, remote-specific boards (WeWorkRemotely, RemoteOK).

## User Criteria

Collect these from the user (all optional, prompt for missing):

| Field | Example | Required |
|-------|---------|----------|
| Role | "frontend developer" | Yes |
| Location | "Berlin" or "remote" | No |
| Salary min | "€60,000" | No |
| Salary max | "€90,000" | No |
| Remote | "fully remote" / "hybrid" / "onsite" / "any" | No |
| Keywords | "React, TypeScript, startup" | No |
| Experience level | "senior" / "mid" / "junior" | No |

## Matching Algorithm

Score each job listing against the user's profile (from `profile.json`):

1. **Skills overlap** (40% weight): Count skills from profile that appear in job description. Normalize by total required skills.
2. **Experience level** (20% weight): Match years of experience and seniority to job level.
3. **Location fit** (20% weight): Exact match = 1.0, same region = 0.7, remote-friendly = 0.5.
4. **Salary fit** (15% weight): Within range = 1.0, below min = scaled penalty.
5. **Keyword boost** (5% weight): Bonus for preferred keywords in description.

**Match score** = weighted sum, displayed as percentage.

## Presentation

For each match, show:
- **Title** and **Company**
- **Location** and **Remote policy**
- **Salary** (if available)
- **Match score** with breakdown
- **Apply URL**
- **Key matching skills** and **Missing skills**

Present top 5–10 matches. User picks which to apply to.

## Caveats

- Web search results are snippets — full job descriptions may differ.
- Salary data is often missing from listings; don't auto-filter on salary alone.
- Always confirm match with user before proceeding to application.
