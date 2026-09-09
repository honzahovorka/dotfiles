# Global instructions

## Start with a plan

- **Unless I explicitly say otherwise, start with a plan.** Research as much as you need — code, specs, sibling repos, tickets — then present the plan and **wait for my approval before creating or editing any file.** Use plan mode where it's available.
- The plan must state **every decision you made yourself**: contract/API shape, naming, what's included vs. dropped, deviations from an implementation you're mirroring, and anything the ticket left unspecified. Those decisions are the point — a list of files you'll touch is not a plan.
- A thin or one-line ticket makes the plan **more** necessary, not less: everything then rests on your inference.
- Applies to multi-file and contract-shaping work. Trivial mechanical edits, single-line fixes, and answering questions need no plan.

## Comments
- keep them SHORT. A 2–3 line comment on a module or function capturing the non-obvious WHY (a gotcha, a parity/regression trap, a "we do X NOT Y because Z" rationale, an ordering/security constraint) is good and wanted. Anything beyond that is not.
- Do NOT write multi-paragraph comment essays, blow-by-blow narration of what the code plainly does, prose that restates the implementation, or "researched notes / history / changelog" dumps inside code. If the comment is longer than the code it describes, cut it down.

## Git

- **Never commit.** Commits are GPG-signed and signing is not available to you — `git commit` will always fail. I commit myself in every project. This also rules out anything that creates commits indirectly: `git merge` (non-ff), `git revert`, `git cherry-pick`, `git rebase`, `git stash pop` conflict resolutions that end in a commit, etc.
- Never push, never amend, never tag.
- Staging changes with `git add` is fine when asked; read-only operations (`status`, `diff`, `log`, `show`, `blame`) are always fine.
- When a task would normally end with a commit, stop after the working tree is ready and summarize what should go into the commit message instead.

## GitHub (`gh`)

- Use `gh` for **reading only**: viewing PRs, issues, comments, CI status, diffs, API reads, etc.
- **Never write via `gh` unless I explicitly ask for that exact action in the current request.** No creating or editing PRs or their descriptions, no posting or replying to comments, no resolving review threads, no reviews/approvals, no label/assignee/milestone changes, no issue edits.
- A general task like "address the review feedback" means fix the code — it is not permission to reply to or resolve the review comments.

