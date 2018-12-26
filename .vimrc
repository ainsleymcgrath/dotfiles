" always
set nocompatible
filetype off

" vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " vundle must manage itself

" look/feel
Plugin 'itchyny/lightline.vim'
Plugin 'noahfrederick/vim-noctu'
Plugin 'morhetz/gruvbox'

" general utils
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-commentary'

" js
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leshill/vim-json'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'


call vundle#end() " required
filetype plugin indent on " required
" endvundle

" da basics
filetype plugin indent on 
syntax on 
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" backups & swaps -- who cares!
set nobackup 
set nowritebackup 
set noswapfile 

" make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" look / feel
set number " line numbers
colorscheme gruvbox 
set background=dark
set laststatus=2
set noshowmode " because lightline takes care of it!
autocmd vimenter * NERDTree " show me that file tree immediately



" mappings
noremap <C-e> :NERDTreeToggle<CR>
noremap <C-p>; :Files<CR>

