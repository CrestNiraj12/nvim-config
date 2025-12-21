# Avante Rules

## ⚠️ NO AUTO-COMMITS
**Do NOT commit unless explicitly requested. Only use git with proper formatting.**

---

## Commit Format
```
<gitmoji> <type>(<scope>): <description>

<body>
```

## Types & Gitmojis
| Emoji | Type | Purpose |
|-------|------|---------|
| ✨ | feat | New feature |
| 🐛 | fix | Bug fix |
| 📚 | docs | Documentation |
| 💄 | style | Code formatting |
| ♻️ | refactor | Refactoring |
| ⚡ | perf | Performance |
| ✅ | test | Tests |
| 👷 | build | Build system |
| 💚 | ci | CI/CD |
| 🔧 | chore | Other changes |
| ⏪ | revert | Revert commit |
| 🎉 | init | Initial commit |
| 🔥 | remove | Remove code/files |
| 🚑 | hotfix | Critical fix |
| 🔒 | security | Security fix |

## Rules
- Subject: Max 50 chars, capitalize first letter, imperative mood, no period
- Optional scope if unclear
- Body: Explain WHAT & WHY, wrap at 72 chars
- Blank line between subject and body

## Examples
```
✨ feat(auth): add JWT validation

Implement JWT middleware to secure API endpoints.
Validates tokens on all protected routes.
```

