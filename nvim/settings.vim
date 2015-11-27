" Paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>k

" ================ github.com/sjl/dotfiles ===========
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Resize splits when the window is resized
au VimResized * :wincmd =
noremap <silent> <Leader>= :wincmd =<CR>

" ================ Better spliting =================
" http://robots.thoughtbot.com/post/48275867281/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" ================ RVM =============================
" http://rvm.io/integration/vim
set shell=/bin/bash

" ================ MISC ============================
" Use ack instead of grep
set grepprg=ack

" [rails.vim] projections - typing `:Efactory users` will open the users factory
" https://github.com/pjg/dotfiles
let g:rails_projections = {
      \ "test/factories/*.rb": {
      \   "command":   "factory",
      \   "affinity":  "collection",
      \   "alternate": "app/models/%i.rb",
      \   "related":   "db/schema.rb#%s",
      \   "test":      "test/models/%i_test.rb",
      \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \   "keywords":  "factory sequence"
      \ },
      \ "spec/factories/*.rb": {
      \   "command":   "factory",
      \   "affinity":  "collection",
      \   "alternate": "app/models/%i.rb",
      \   "related":   "db/schema.rb#%s",
      \   "test":      "spec/models/%i_test.rb",
      \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \   "keywords":  "factory sequence"
      \ }
      \}

" ================ Custom Rails commands ===========
command! Rroutes :e config/routes.rb

" Strip trailing whitespaces
" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" Use Q to intelligently close a window
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " We should never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" Wrapping
" http://vimcasts.org/episodes/soft-wrapping-text/
function! SetupWrapping()
  set wrap linebreak nolist
  set showbreak=…
endfunction

command! -nargs=* Wrap :call SetupWrapping()<CR>

" NERDTree
" Auto open nerd tree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0
" Focus in the main content window
let g:nerdtree_tabs_focus_on_files = 1

let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_smart_case = 1
" Default # of completions is 100, that's crazy.
let g:deoplete#max_list = 5
" Set minimum syntax keyword length.
let g:deoplete#auto_completion_start_length = 3
" This makes sure we use deoplete completefunc instead of
" the one in rails.vim, otherwise this plugin will crap out.
let g:deoplete#force_overwrite_completefunc = 1
" Define keyword.
if !exists('g:deoplete#keyword_patterns')
  let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineFugitive()
  let string = ''
  let string .= LightLineHunks()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⭠ '  " edit here for cool mark
      let _ = fugitive#head()
      let string .= strlen(_) ? mark._ : ''
      return string
    endif
  catch
  endtry
  return string
endfunction

function! LightLineHunks()
  if exists('*GitGutterGetHunkSummary')
    if !get(g:, 'gitgutter_enabled', 0)
      return ''
    endif
    let non_zero_only = 1
    let hunks = GitGutterGetHunkSummary()
    let string = ''
    let hunk_symbols = ['+', '~', '-']
    if !empty(hunks)
      for i in [0, 1, 2]
        if non_zero_only == 0 || hunks[i] > 0
          let string .= printf('%s%s ', hunk_symbols[i], hunks[i])
        endif
      endfor
    endif
    return string
  else
    return ''
  endif
endfunction
"
" Use status bar even with single buffer
set laststatus=2

" Session autosave
let g:session_autosave = 'no'

" CtrlP
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" Default to filename searches - so that appctrl will find application controller
let g:ctrlp_by_filename = 1
" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0
" Show dotfiles
let g:ctrlp_show_hidden = 1
" Set no file limit
let g:ctrlp_max_files = 0
" Do not clear filenames cache
let g:ctrlp_clear_cache_on_exit = 0

let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

" We don't want to use Ctrl-p as the mapping because
let g:ctrlp_map = ',t'
nnoremap <silent> ,t :CtrlP<CR>

" Additional mapping for buffer search
nnoremap <silent> ,b :CtrlPBuffer<cr>

" Cmd-Shift-P to clear the cache
nnoremap <silent> <D-P> :ClearCtrlPCache<cr>

" Idea from :http://www.charlietanksley.net/blog/blog/2011/10/18/vim-navigation-with-lustyexplorer-and-lustyjuggler/
" Open CtrlP starting from a particular path, making it much
" more likely to find the correct thing first. mnemonic 'jump to [something]'
map ,ja :CtrlP app/assets<CR>
map ,jm :CtrlP app/models<CR>
map ,jc :CtrlP app/controllers<CR>
map ,jv :CtrlP app/views<CR>
map ,jh :CtrlP app/helpers<CR>
map ,jl :CtrlP lib<CR>
map ,jp :CtrlP public<CR>
map ,js :CtrlP spec<CR>
map ,jf :CtrlP fast_spec<CR>
map ,jd :CtrlP db<CR>
map ,jC :CtrlP config<CR>
map ,jV :CtrlP vendor<CR>
map ,jF :CtrlP factories<CR>
map ,jT :CtrlP test<CR>

"Cmd-Shift-(M)ethod - jump to a method (tag in current file)
"Ctrl-m is not good - it overrides behavior of Enter
noremap <silent> <D-M> :CtrlPBufTag<CR>

let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Emmet
" let g:user_emmet_install_global = 0
" autocmd FileType html,css,eruby EmmetInstall
" autocmd FileType html,css,eruby imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" autocmd FileType html,css,eruby let g:user_emmet_expandabbr_key='<Tab>'

let g:user_emmet_leader_key='<C-Z>'

" ================ Syntastic ====================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
