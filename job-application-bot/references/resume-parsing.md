# Resume Parsing

## Supported Formats

- **PDF**: Use the `pdf` tool to extract text, then parse fields.
- **Plain text**: Use `read` tool directly.
- **Fallback**: Ask user to paste key sections if automated parsing fails.

## Field Extraction Strategy

### Contact Info
- Regex for email: `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}`
- Regex for phone: `[\+]?[\d\s\-\(\)]{7,15}`
- Name: typically first line(s) before contact info; if unclear, ask.

### Skills
- Look for sections headed: "Skills", "Technical Skills", "Technologies", "Core Competencies".
- Split on commas, semicolons, or bullet points.
- Categorize: programming languages, frameworks, tools, methodologies, soft skills.
- Infer implicit skills from work experience descriptions (e.g., "built React apps" → React).

### Work Experience
- Pattern: Company name + Title + Date range.
- Date patterns: `MMM YYYY - MMM YYYY`, `YYYY-MM`, `present`, `current`.
- Extract bullet points under each role as highlights.
- Capture quantifiable achievements (percentages, dollar amounts, user counts).

### Education
- Section headers: "Education", "Academic Background".
- Extract: degree, major, institution, graduation year, GPA (if listed).
- Normalize degree names (BS = Bachelor of Science, MS = Master of Science, etc.).

## Output Schema (profile.json)

```json
{
  "name": "Jane Doe",
  "email": "jane@example.com",
  "phone": "+1-555-0123",
  "location": "Berlin, Germany",
  "summary": "Senior frontend developer with 6 years of experience...",
  "skills": {
    "languages": ["TypeScript", "JavaScript", "Python"],
    "frameworks": ["React", "Next.js", "Vue"],
    "tools": ["Git", "Docker", "Figma"],
    "methodologies": ["Agile", "TDD", "CI/CD"],
    "soft": ["Communication", "Mentoring"]
  },
  "experience": [
    {
      "company": "TechCorp",
      "title": "Senior Frontend Developer",
      "startDate": "2021-03",
      "endDate": "present",
      "highlights": [
        "Led migration to Next.js, reducing load time by 40%",
        "Mentored 3 junior developers"
      ]
    }
  ],
  "education": [
    {
      "degree": "BS",
      "field": "Computer Science",
      "institution": "TU Berlin",
      "year": 2019
    }
  ],
  "parsedDate": "2025-01-15T10:30:00Z"
}
```

## Error Handling

- If no skills section found, infer from experience bullets — flag as low-confidence.
- If date ranges ambiguous, default to "startDate"/"endDate" as strings and note uncertainty.
- Always let the user review and correct the parsed profile before using it for matching.
