# Avante Instructions

## Commit Format
```
<gitmoji> <type>(<scope>): <description>

<body>
```
Include body for WHAT/WHY; omit scope if unclear; no trailing period.

## Types & Gitmojis
- ✨ feat: New feature
- 🐛 fix: Bug fix
- 📚 docs: Docs
- 💄 style: Formatting
- ♻️ refactor: Refactor
- ⚡ perf: Perf
- ✅ test: Tests
- 👷 build: Build
- 💚 ci: CI
- 🔧 chore: Other
- ⏪ revert: Revert

Extra: 🎉 init, 🔥 remove, 🚑 hotfix, 🔒 security, 🚀 deploy

## Guidelines
- Imperative: "Add", "Fix"
- Subject <=50 chars, capitalize, no period
- Body: WHAT/WHY, wrap 72

## Examples
```
✨ feat(auth): add JWT validation

Implement middleware for JWTs.
```
```
🐛 fix(api): handle nil user
```

## Usage
- Generate for staged diff using Avante.
