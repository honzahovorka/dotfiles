map <Leader>nl :set nolist<CR>
map <Leader>sl :set list<CR>

" Map tab to %
map <tab> %

" Move to the begining of the line and to the end of the line
"noremap H ^
"noremap L g_

" Map semicilon to colon
nnoremap ; :
"
" change word from register
" http://stackoverflow.com/a/5357194/653660
nmap <silent> cp "_cw<C-R>"<Esc>

" Open the Ag command and place the cursor into the quotes
nmap ,ag :Ag ""<Left>
nmap ,af :AgFile ""<Left>
nmap ,aw :Ag "<cword>"<cr>

" Automatically jump to a file at the correct line number
" i.e. if your cursor is over /some/path.rb:50 then using 'gf' on it will take
" you to that line
" use ,gf to go to file in a vertical split
nnoremap <silent> ,gf   :vertical botright wincmd F<CR>
nnoremap <silent> <C-F> :vertical botright wincmd F<CR>

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Sudo write
" w!! to write a file as sudo
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null

" If you visually select something and hit paste
" that thing gets yanked into your buffer. This
" generally is annoying when you're copying one item
" and repeatedly pasting it. This changes the paste
" command in visual mode so that it doesn't overwrite
" whatever is in your paste buffer.
vnoremap p "_dP

" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> ,f <C-]>

" Navigate to the block surrounding this one
nnoremap <silent> ,orb :normal varar%<esc><esc>

" Camelcasenotion
map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e

sunmap W
sunmap B
sunmap E

" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
nnoremap ,yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
nnoremap ,ow "_diwhp

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" ,# Surround a word with #{ruby interpolation}
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

map ,` ysiw`

" ,q to toggle quickfix window (where you have stuff like Ag)
" ,oq to open it back up (rare)
nmap <silent> ,qc :cclose<CR>
nmap <silent> ,qo :copen<CR>

" Move between split windows by using the four directions H, L, K, J
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Type ,hl to toggle highlighting on/off, and show current value.
noremap ,hl :set hlsearch! hlsearch?<CR>

" These are very similar keys. Typing 'a will jump to the line in the current
" file marked with ma. However, `a will jump to the line and column marked
" with ma.  It’s more useful in any case I can imagine, but it’s located way
" off in the corner of the keyboard. The best way to handle this is just to
" swap them: http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

" keep visually selected block when aligning
vmap < <gv
vmap > >gv

" SplitJoin plugin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Fugitive Shortcuts
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
nmap <silent><leader>gd :Gdiff<cr>

" <leader><leader> toggles between buffers
nnoremap <space><space> <c-^>

" Hack to get C-h working in neovim
" https://github.com/neovim/neovim/issues/2048
nmap <BS> <C-W>h

" FZF
nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <leader>e :call FzfFilePreview()<CR>

" Get rid of ESC
imap jj <Esc>

" Open hotkeys
map <C-p> :Files<CR>
nnoremap <C-g> :Rg<Cr>
nmap <leader>g :Rg<CR>
nmap <leader>. :Files<CR>
nmap <leader>; :Buffers<CR>

" Very magic search by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Ctrl+/ to toggle comments
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" hange a word and then to change the next occurrence of it you can just do '.'
nnoremap <leader>x *``cgn
