let g:python_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')
let g:python3_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')

call plug#begin('~/.vim/plugged')

" look/feel
Plug 'itchyny/lightline.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'google/vim-searchindex'

" general utils
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'qpkorr/vim-bufkill'

"completions
" Plug 'zxqfl/tabnine-vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" js / web standards
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'html', 'css'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mattn/emmet-vim'

" python
Plug 'psf/black', { 'for': 'python' }
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }


" ansible
Plug 'pearofducks/ansible-vim'

call plug#end()

" da basics
filetype plugin indent on
syntax on
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set cindent " Intellegently dedent / indent new lines based on rules.

" plugin-related
let g:deoplete#auto_complete_delay = 100 " to avoid battle with Semshi
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0 " deoplete handles it

" mappings
let mapleader=' '

noremap <C-e> :NERDTreeToggle<CR>
noremap <C-t> :TagbarToggle<CR>
noremap <C-p> :Files<CR>
noremap <C-l> :Ag<CR>
noremap <leader>ll :Ag!<CR>
noremap <leader>at :ALEToggle<CR>
noremap <leader>st :SignifyToggle<CR>
noremap <leader>ht :nohlsearch<CR>
noremap <Leader>bf :Buffers<CR>
noremap <Leader>tg :Tags<CR>
noremap <Leader>bt :BTags<CR>
noremap <Leader>gsb :GFiles?<CR>

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

" and also more insane
let $FZF_DEFAULT_COMMAND = 'ag --ignore .git -l -g ""'
let $BAT_THEME = 'GitHub'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('right:50%')
  \                         : fzf#vim#with_preview('right:50%'),
  \                 <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%'), <bang>0)
set rtp+=/usr/local/opt/fzf

" look / feel
set number " line numbers
colorscheme PaperColor
set background=light
set laststatus=2
let NERDTreeShowHidden=1
set cursorline
set noshowmode " because lightline takes care of it!

" colors selected from https://github.com/NLKNguyen/papercolor-theme/blob/master/colors/PaperColor.vim#L40-L57
hi semshiImported ctermfg=25 cterm=bold
hi semshiSelf ctermfg=31 cterm=bold
hi semshiAttribute ctermfg=238
hi semshiGlobal ctermfg=238 cterm=bold
hi semshiBuiltin ctermfg=91
hi semshiSelected ctermbg=190 ctermfg=28 cterm=bold
hi semshiParameter ctermfg=31

" python linting stuff
let g:semshi#error_sign = v:false " let ale do it
let g:ale_flake8_options = '--max-line-length=121'
let g:ale_pylint_options = '--max-line-length=121'

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8', 'pylint'],
\ }

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
    \ 'colorscheme': 'PaperColor',
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
" autocmd BufWritePre,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd FileType *.js,*.jsx,*.json,*.jsonp,*.css,*.scss,*.html setlocal shiftwidth=2

" python autoformatting
autocmd BufWritePre,InsertLeave *.py execute ':Black'
autocmd FileType *.py setlocal shiftwidth=4

" yaml autoformatting
autocmd FileType yaml setlocal shiftwidth=2
autocmd BufRead,BufNewFile **/server/*.yml setlocal ft=yaml.ansible

