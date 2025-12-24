# Features & Roadmap Tracking

## Feature tracking file

When working on a project with multiple features, bugs, or improvements, maintain a `docs/FEATURES.md` file to track progress.

## Structure

Use this lightweight structure:

```markdown
# Features & Roadmap

## Category Name

- [x] Completed feature with description
- [ ] Todo feature with description

## Bugs Fixed

- [x] Fixed bug with description
```

## Rules

- Keep descriptions concise and actionable
- Only document what has been done or is planned
- Do not extrapolate or add speculative improvements
- Use checkboxes for all items (done and todo)
- Group related items by category
- Update the file as you complete tasks

## When to create

Create this file when:
- Project has multiple features to track
- Multiple bugs need fixing
- Working on a roadmap
- User requests feature tracking

## Example

```markdown
# Features & Roadmap

## Infrastructure

- [x] Terraform deployment (Cloud Run, Firestore)
- [x] Auto-compute image URLs from variables
- [ ] Multi-environment setup (dev/staging/prod)

## Development

- [x] Mise tasks with namespaces
- [x] Bruno API collection
- [ ] Pre-commit hooks

## Bugs Fixed

- [x] Docker PYTHONPATH module imports
- [x] Google Auth in containers
```
