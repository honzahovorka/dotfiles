# Global instructions

## Git

- **Never commit.** Commits are GPG-signed and signing is not available to you — `git commit` will always fail. I commit myself in every project. This also rules out anything that creates commits indirectly: `git merge` (non-ff), `git revert`, `git cherry-pick`, `git rebase`, `git stash pop` conflict resolutions that end in a commit, etc.
- Never push, never amend, never tag.
- Staging changes with `git add` is fine when asked; read-only operations (`status`, `diff`, `log`, `show`, `blame`) are always fine.
- When a task would normally end with a commit, stop after the working tree is ready and summarize what should go into the commit message instead.
