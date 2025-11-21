# Avante Instructions

## Commit Message Generation

When generating commit messages, follow these guidelines:

### Format
```
<gitmoji> <type>(<scope>): <description>

<body>

<footer>
```

### Types with Gitmojis
- **✨ feat**: A new feature
- **🐛 fix**: A bug fix
- **📚 docs**: Documentation only changes
- **💄 style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **♻️ refactor**: A code change that neither fixes a bug nor adds a feature
- **⚡ perf**: A code change that improves performance
- **✅ test**: Adding missing tests or correcting existing tests
- **👷 build**: Changes that affect the build system or external dependencies
- **💚 ci**: Changes to CI configuration files and scripts
- **🔧 chore**: Other changes that don't modify src or test files
- **⏪ revert**: Reverts a previous commit

### Additional Common Gitmojis
- **🎉 init**: Initial commit
- **🔥 remove**: Remove code or files
- **🚑 hotfix**: Critical hotfix
- **🔒 security**: Fix security issues
- **🚀 deploy**: Deploying stuff
- **📱 responsive**: Work on responsive design
- **🎨 improve**: Improve structure / format of the code
- **🔖 release**: Release / Version tags

### Guidelines
1. Use the imperative mood in the subject line (e.g., "Add feature" not "Added feature")
2. Keep the subject line under 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the body to explain what and why vs. how
6. Wrap the body at 72 characters

### Examples
```
feat(auth): add JWT token validation

Implement JWT token validation middleware to secure API endpoints.
This adds authentication to all protected routes and validates tokens
against the configured secret key.

Closes #123
```

```
fix(api): resolve null pointer exception in user service

Handle case where user object is null before accessing properties.
This prevents crashes when processing invalid user requests.
```

```
docs(readme): update installation instructions

Add missing dependencies and clarify setup steps for new contributors.
```

## Git Workflow Integration

When working with git changes:
1. Analyze the diff to understand what changed
2. Identify the primary purpose of the changes
3. Choose the appropriate commit type
4. Write a clear, concise description
5. Add context in the body if needed
