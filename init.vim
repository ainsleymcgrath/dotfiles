let g:python_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')
let g:python3_host_prog = expand('~/.config/nvim/neovim_venv/bin/python3')

call plug#begin('~/.vim/plugged')

" look/feel
Plug 'itchyny/lightline.vim'
Plug 'google/vim-searchindex'
Plug 'jnurmine/Zenburn'

" general utils
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-sneak'
Plug 'hylang/vim-hy'

"completions
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'ervandew/supertab'

" js / web standards
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'html', 'css'] }
Plug 'elzr/vim-json', { 'for': 'json' }

" python
Plug 'psf/black', { 'for': 'python', 'tag': '19.10b0' }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

call plug#end()

" da basics
" filetype plugin indent on
syntax on
set expandtab " use spaces instead of tabs.
set shiftround " tab / shifting moves to closest tabstop.
set cindent " Intellegently dedent / indent new lines based on rules.

" plugin-related
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0 " deoplete handles it
let  g:jedi#goto_stubs_command='' " i don't use this and it collides with Ferret
let g:tagbar_sort = 0 " hate that this isn't a default...
let g:tagbar_width = 50
let g:tagbar_zoomwidth = 0
let g:tagbar_autofocus = 1
let g:BufKillCreateMappings=0
" scroll top down for completions
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" mappings
let mapleader=' '

inoremap jj <Esc>
cnoremap jj <Esc>
noremap <C-e> :NERDTreeToggle<CR>
noremap <C-t> :TagbarToggle<CR>
noremap <C-P> :Files!<CR>
noremap <C-l> :Rg!<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>/ :BLines!<CR>
noremap <Leader>tg :Tags<CR>
noremap <Leader>gsb :GFiles!?<CR>

noremap <leader>at :ALEToggle<CR>
noremap ]a :ALENextWrap<CR>
noremap [a :ALEPreviousWrap<CR>
noremap ]A :ALEFirst<CR>
noremap [A :ALELast<CR>
noremap <leader>st :SignifyToggle<CR>
noremap <silent><expr> <leader>ht (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
noremap <silent><expr> <leader>ln (&rnu ? ':set nornu' : ':set rnu')."\n"
noremap <leader>se :Semshi enable<CR>

" backups & swaps -- who cares!
set nobackup
set nowritebackup
set noswapfile

" make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set showmatch " live match highlighting
set gdefault " use the `g` flag by default.

" and also more insane
let $FZF_DEFAULT_COMMAND = 'rg -l ""'
let $BAT_THEME = 'zenburn'

set rtp+=/usr/local/opt/fzf

" look / feel
colorscheme zenburn
set number " line numbers
set laststatus=2
let NERDTreeShowHidden=1
set cursorline
set noshowmode " because lightline takes care of it!
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignChange ctermbg=NONE ctermfg=yellow
highlight SignifySignAdd ctermbg=NONE ctermfg=green
highlight SignifySignDelete ctermbg=NONE ctermfg=red
highlight LineNr ctermbg=NONE
highlight CursorLineNr ctermbg=NONE

" python linting stuff
let g:semshi#error_sign = v:false " let ale do it
let g:ale_flake8_options = '--max-line-length=88'
let g:ale_pylint_options = '--max-line-length=88'

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
    \ 'colorscheme': 'jellybeans',
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
