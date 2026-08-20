# My Neovim configuration

## Omarchy themes

On Omarchy, Neovim follows the active desktop theme without depending on
LazyVim. The integration reads Omarchy's generated state from
`~/.local/state/omarchy/current`, translates the LazyVim-oriented theme spec
into a regular `lazy.nvim` plugin spec, and applies the selected colorscheme.

All stock theme engines are registered lazily so a running Neovim can switch
between them. The user-owned `theme-set` hook writes a small signal under
`$XDG_RUNTIME_DIR`; each Neovim instance watches that signal and reloads the
new palette. Packaged files under `/usr/share/omarchy` are read-only inputs and
are never modified.

Outside Omarchy, the configuration falls back to Catppuccin Mocha and retains
`dark-notify` for platform light/dark changes.

### Commands

- `:OmarchyThemeInfo` shows the selected theme, plugin, state root, signal
  path, and the latest load error.
- `:OmarchyThemeReload` manually rereads and applies the current Omarchy theme.
- `:Lazy sync` installs any newly registered theme engines.

Stock and custom themes whose plugins are already registered switch live. A
custom theme using an unknown plugin is loaded on the next Neovim startup;
live reload reports that a restart is required.
