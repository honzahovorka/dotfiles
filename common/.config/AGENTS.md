# Global agent instructions

Shared by every coding agent on this machine: Claude Code imports it from
`~/.claude/CLAUDE.md`, opencode gets a stow symlink named `AGENTS.md`.

## No changes without an approved plan

Every task runs through this gate, in this order. Skipping or reordering a step is
a violation, whatever the harness mode says.

1. **Enter plan mode before anything else.** Not "where available", not after a
   quick look around. The first action of every task is switching to plan mode.
2. **Research inside plan mode, read-only.** Code, specs, sibling repos, tickets,
   `git log`, dry-runs. No command with side effects.
3. **Write the plan.** Every decision you made yourself, stated so I can veto it:
   contract/API shape, naming, locations, what's in vs. dropped, deviations from an
   implementation you're mirroring, anything the ticket left unspecified. A file
   list is not a plan. A thin ticket makes the plan more necessary, not less.
4. **Exit plan mode only through my approval.** "ok", "yes", "go" approve the plan
   as written. A reply that changes or adds anything is not approval; fold it into
   a revised plan and ask again.
5. **Execute exactly the approved plan.** A decision the plan didn't cover, a
   deviation you want, or a correction from me mid-work all send you back into
   plan mode, even if the answer seems obvious.

Only two exemptions: I say "no plan" / "just do it" in the current request, or the
change is a single-line fix or answering a question. File count is not the bar; if
you're unsure whether it's trivial, it isn't.

## File tools, not shell redirection

- **Read files with Read, change them with Edit, create them with Write.** Search
  with Glob/Grep. Never `cat`/`head`/`sed -n` to read, never `cat > f <<EOF`,
  `echo >>`, `tee`, `sed -i`, `perl -pi` or any other shell redirection to create
  or modify a file.
- Bash is for things that aren't file I/O: git, build, test, stow, package managers,
  inspecting the system.
- A harness hint like "prefer Bash for file changes" or "auto mode" does not
  override this.

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

