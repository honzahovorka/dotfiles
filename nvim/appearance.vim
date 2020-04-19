let g:nord_uniform_diff_background = 1
let g:nord_bold_vertical_split_line = 0

colorscheme nord
set background=dark

hi! link txtBold Identifier
hi! link MatchParen DiffText
hi! PreProc gui=bold
hi! LineNR guifg=#004C60 gui=bold guibg=#002B36 ctermfg=146
hi! link NonText VertSplit
hi! link htmlLink Include
hi! Visual ctermbg=233
hi! Type gui=bold
hi! SignColumn ctermbg=NONE
hi! DiffAdd ctermbg=NONE
hi! DiffChange ctermbg=NONE
hi! DiffDelete ctermbg=NONE
hi! DiffText ctermbg=NONE
hi! ColorColumn ctermbg=NONE

" Italic support
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" Make it beautiful - colors and fonts
if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M
  set lines=60
  set columns=190

  if has("gui_gtk2")
    set guifont=Inconsolata\ XL\ 12,Inconsolata\ 15,Monaco\ 12
  else
    set guifont=Inconsolata\ XL:h17,Inconsolata:h20,Monaco:h17
  end
else
  let g:CSApprox_loaded = 1
endif

let g:startify_files_number = 5
let g:startify_bookmarks=['~/.config/fish/config.fish', '~/.config/nvim/init.vim', '~/projects']
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   My most recently used files in tre current directory:'] },
  \ { 'type': 'files',     'header': ['   My most recently used files:'] },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'sessions',  'header': ['   Saved sessions:'] },
  \ ]
