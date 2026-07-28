# Global instructions

## Git

- **Never commit.** Commits are GPG-signed and signing is not available to you — `git commit` will always fail. I commit myself in every project. This also rules out anything that creates commits indirectly: `git merge` (non-ff), `git revert`, `git cherry-pick`, `git rebase`, `git stash pop` conflict resolutions that end in a commit, etc.
- Never push, never amend, never tag.
- Staging changes with `git add` is fine when asked; read-only operations (`status`, `diff`, `log`, `show`, `blame`) are always fine.
- When a task would normally end with a commit, stop after the working tree is ready and summarize what should go into the commit message instead.

## GitHub (`gh`)

- Use `gh` for **reading only**: viewing PRs, issues, comments, CI status, diffs, API reads, etc.
- **Never write via `gh` unless I explicitly ask for that exact action in the current request.** No creating or editing PRs or their descriptions, no posting or replying to comments, no resolving review threads, no reviews/approvals, no label/assignee/milestone changes, no issue edits.
- A general task like "address the review feedback" means fix the code — it is not permission to reply to or resolve the review comments.
