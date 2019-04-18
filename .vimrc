" always
set nocompatible
filetype off

" vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " vundle must manage itself

" look/feel
Plugin 'itchyny/lightline.vim'
Plugin 'morhetz/gruvbox'
Plugin 'google/vim-searchindex'

" general utils
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'zxqfl/tabnine-vim'
Plugin 'mattn/emmet-vim'
Plugin 'w0rp/ale'

" js
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'prettier/vim-prettier'
Plugin 'elzr/vim-json'
Plugin 'jeetsukumaran/vim-pythonsense'

" python
Plugin 'ambv/black'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-python/python-syntax'

" elixir
Plugin 'elixir-editors/vim-elixir'

" elm
Plugin 'ElmCast/elm-vim'

" ansible
Plugin 'pearofducks/ansible-vim'

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
set cindent " Intellegently dedent / indent new lines based on rules.

" mappings
let mapleader=' '

noremap <C-e> :NERDTreeToggle<CR>
noremap <C-p> :Files<CR>
noremap <C-l> :Ag<CR>
noremap <leader>at :ALEToggle<CR>
noremap <leader>st :SignifyToggle<CR>
noremap <leader>ht :nohlsearch<CR>
noremap <Leader>b :Buffers<CR> 

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
let NERDTreeShowHidden=1
set cursorline
set noshowmode " because lightline takes care of it!

let g:python_highlight_string_formatting=1
let g:python_highlight_string_format=1
let g:python_highlight_string_templates=1
let g:python_highlight_builtins=1

" for reporting ale errors in the statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'linterstatus' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'linterstatus': 'LinterStatus'
    \ },
    \ }

" more sensible splits
set splitright
set splitbelow

" javasdcript autoformatting
let g:prettier#quickfix_enabled = 0 
let g:prettier#autoformat = 0 
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
autocmd BufWritePre,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd FileType *.js,*.jsx,*.json,*.jsonp,*.css,*.scss,*.html setlocal shiftwidth=2

" python autoformatting
autocmd BufWritePre,InsertLeave *.py execute ':Black' 
autocmd FileType *.py setlocal shiftwidth=4

" yaml autoformatting
autocmd FileType yaml setlocal shiftwidth=2
autocmd BufRead,BufNewFile **/server/*.yml setlocal ft=yaml.ansible

