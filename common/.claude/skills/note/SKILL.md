---
name: note
description: Create a new note in the Obsidian vault at ~/Documents/Vault following the vault's template and naming conventions. Use when the user asks to "make a note", "add a note", "note this down", "create a vault/Obsidian note", or jot something into their vault.
---

# Create an Obsidian vault note

Create a new note in the Obsidian vault at `~/Documents/Vault`, following the
vault's existing structure. The vault's own rules live in
`~/Documents/Vault/AGENTS.md` — defer to that file if it ever conflicts with the
steps below.

## Rules

- **Folder:** write the note to `~/Documents/Vault/Inbox/` (this is where all
  notes live, matching the vault's `AGENTS.md`).
- **Filename:** `YYYY-MM-DD_title-of-the-note.md`
  - Date is today's date.
  - The slug after the date is the title: lowercase, ASCII, words separated by
    `-`. Strip punctuation; transliterate accents (e.g. `ž → z`). Keep it short.
  - Example: a note titled "Home network" created on 2026-01-12 →
    `2026-01-12_home-network.md`
- **Template:** base every note on `~/Documents/Vault/Templates/note.md`:

  ```markdown
  ---
  date: YYYY-MM-DD
  tags:
    -
  urls:
    -
  ---

  # Title
  ```

  - Fill `date` with today's date.
  - `tags:` — leave the empty `  -` placeholder unless the user gives tags or the
    topic clearly matches ones already used in the vault (e.g. `personal`,
    `coding`, `work`). Use 2-space indentation for list items.
  - `urls:` — fill in any URL the user provides, otherwise leave the empty `  -`.
  - The `# Title` heading is the human-readable title (not the slug), e.g.
    `# Home network`.

## Steps

1. Determine the title from the user's request. If they only gave content and no
   clear title, derive a concise one.
2. Compute today's date and build the filename slug from the title.
3. Check whether `~/Documents/Vault/Inbox/<filename>` already exists. If it does,
   ask whether to append to it or pick a different title rather than overwriting.
4. Create the file from the template, filling in `date`, the `# Title` heading,
   and any body content the user provided.
5. Report the full path of the created note.

## Notes

- Keep the frontmatter exactly in the template's shape; Obsidian and other vault
  tooling rely on the `date`, `tags`, and `urls` keys.
- Only put the note in `Inbox/` — do not create new top-level folders.
