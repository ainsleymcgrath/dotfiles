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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mhinz/vim-signify'

" js
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'prettier/vim-prettier'
Plugin 'leshill/vim-json'

" python
Plugin 'ambv/black'

" elixir
Plugin 'elixir-editors/vim-elixir'

" ale [linter]-- see |ale-related| below
Plugin 'w0rp/ale' " TODO: https://github.com/w0rp/ale#2ii-fixing

call vundle#end() " required
filetype plugin indent on " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" endvundle

" da basics
filetype plugin indent on 
syntax on 
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" mappings
noremap <C-e> :NERDTreeToggle<CR>
noremap <C-p> :Files<CR>

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
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" look / feel
set number " line numbers
colorscheme gruvbox 
set background=dark
set laststatus=2
set noshowmode " because lightline takes care of it!
let NERDTreeShowHidden=1

" more sensible splits
set splitright
set splitbelow

" autoformatting
let g:prettier#quickfix_enabled = 0 
let g:prettier#autoformat = 0 " format when changing, saving, or leaving insert mode
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd BufWritePre *.py execute ':Black' 


