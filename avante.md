# Avante Instructions

## Commit Message Generation

Follow these rules when generating commit messages.

### Format
```
<gitmoji> <type>(<scope>): <description>

<body>
```
(Only include a body if it adds useful WHAT/WHY context; wrap at 72 chars. Omit scope if unclear. No trailing period in the subject.)

### Types with Gitmojis
- ✨ feat: A new feature
- 🐛 fix: A bug fix
- 📚 docs: Documentation only changes
- 💄 style: Formatting / style-only changes (no logic)
- ♻️ refactor: Code change that neither fixes a bug nor adds a feature
- ⚡ perf: Performance improvement
- ✅ test: Adding or correcting tests
- 👷 build: Build system / external dependencies
- 💚 ci: CI configuration / scripts
- 🔧 chore: Other changes not affecting src or tests
- ⏪ revert: Revert a previous commit

### Additional Gitmojis (optional)
- 🎉 init: Initial commit
- 🔥 remove: Remove code or files
- 🚑 hotfix: Critical urgent fix
- 🔒 security: Security fix / improvement
- 🚀 deploy: Deployment related changes
- 📱 responsive: Responsive design work
- 🎨 improve: Structural / formatting improvements
- 🔖 release: Release / version tagging

### Guidelines
1. Imperative mood: "Add", "Refactor", "Fix" (not past tense).
2. Subject <= 50 chars; concise and meaningful.
3. Capitalize subject; no trailing period.
4. Body (if present) explains WHAT and WHY, not HOW.
5. Wrap body at 72 chars.
6. Reference issues if relevant (e.g. "Closes #123").
7. Ensure to include a concise message for major changes, such as the addition of significant components or features, to maintain a clear project history.

### Examples
```
✨ feat(auth): add JWT token validation

Implement middleware validating JWTs on protected routes.
Closes #123
```
```
🐛 fix(api): handle nil user in profile fetch

Guard against nil user object to prevent runtime error.
```
```
📚 docs(readme): clarify local setup steps

Add missing dependency list and quick start instructions.
```

## Git Workflow Integration
1. Stage only logically related changes (`git add -p` if needed).
2. Use AI to draft commit (<leader>gc) from staged diff.
3. Review / edit for accuracy and scope.
4. Commit: `git commit -m "<subject>" -m "<body>"` (body optional).
5. Push or stack as needed.

## Code Review Focus
1. Maintainability / readability
2. Performance implications
3. Security considerations
4. Test coverage adequacy
5. Documentation completeness
6. Consistency with project standards

## Refactoring Suggestions
1. Clarify intent and improve naming
2. Reduce duplication / increase cohesion
3. Prefer incremental improvements
4. Preserve backward compatibility when possible
5. Avoid premature optimization

## Usage With Avante
- Avante loads this file via `instructions_file = "avante.md"` and injects it as system guidance for prompts.
- Press `<leader>gc` (mapping) to generate a gitmoji conventional commit for staged changes.
- Ensure changes are staged (`git add ...`) first.
- Ask follow-ups (e.g. "Shorten subject", "Remove body", "Add scope (api)").

## Quick Prompt Variants
- "Generate a gitmoji conventional commit for staged diff."
- "Provide only header line, no body."
- "Suggest better scope for this diff."

End of instructions.
