call plug#begin('~/.config/nvim/plugged')

" Appearance
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gregsexton/gitv'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Project
Plug 'vifm/vifm.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-rooter'

" Languages
Plug 'rust-lang/rust.vim'

" Misc
Plug 'mhinz/vim-startify'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/camelcasemotion'
Plug 'vim-scripts/matchit.zip'
Plug 'bogado/file-line'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/lastpos.vim'
Plug 'vim-scripts/sudo.vim'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

call plug#end()
