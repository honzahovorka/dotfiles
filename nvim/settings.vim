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

" Open Startify and NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if !argc() | Startify | winc h | endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
set omnifunc=ale#completion#OmniFunc

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1

" Use status bar even with single buffer
set laststatus=2

" Session autosave
let g:session_autosave = 'no'

let g:indentLine_fileTypeExclude = ['startify', 'vifm']
autocmd TermEnter * IndentLinesDisable

" vim-rooter
let g:rooter_patterns = ['Makefile', 'make', 'Rakefile', '.git/']
