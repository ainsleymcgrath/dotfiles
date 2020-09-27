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
Plug 'junegunn/vim-plug'
Plug 'wincent/ferret'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-sneak'
Plug 'hylang/vim-hy'

"completions
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
Plug 'ervandew/supertab'

" js / web standards
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'herringtondarkholme/yats.vim', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'html', 'css', 'json'] }
Plug 'elzr/vim-json', { 'for': 'json' }


" python
Plug 'psf/black', { 'for': 'python', 'tag': '19.10b0' }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }

call plug#end()

" da basics
" filetype plugin indent on
syntax on
set expandtab " use spaces instead of tabs.
" set shiftround " tab / shifting moves to closest tabstop.
" set cindent " Intellegently dedent / indent new lines based on rules.

" plugin-related
" let g:deoplete#enable_at_startup = 1
" let g:jedi#completions_enabled = 0 " deoplete handles it
" let  g:jedi#goto_stubs_command='' " i don't use this and it collides with Ferret
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
noremap <Leader>fo :Black<CR>
nmap <leader>fr <Plug>(FerretAcks)
noremap :W :w

noremap <leader>st :SignifyToggle<CR>
noremap <silent><expr> <leader>ht (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
noremap <silent><expr> <leader>ln (&rnu ? ':set nornu' : ':set rnu')."\n"
noremap <leader>se :Semshi enable<CR>

" used below
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>n <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocList -N -I diagnostics<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList -I -N outline<cr>
nnoremap <silent><nowait> <space>y  :<C-u>CocList yank<cr>
nnoremap <silent><nowait> <space>pyi  :<C-u>CocCommand python.setInterpreter<cr>
noremap ]e <Plug>(coc-diagnostic-next-error)
noremap [e <Plug>(coc-diagnostic-prev-error)
noremap ]a <Plug>(coc-diagnostic-next)
noremap [a <Plug>(coc-diagnostic-prev)

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
let $FZF_DEFAULT_COMMAND = 'rg -l --files""'
let $BAT_THEME = 'zenburn'

set rtp+=/usr/local/opt/fzf

" look / feel
colorscheme zenburn
set number
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
highlight Comment cterm=italic gui=italic

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'linterstatus' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'linterstatus': 'StatusDiagnostic'
    \ },
    \ }

" more sensible splits
set splitright
set splitbelow

" javasdcript autoformatting
let g:prettier#config#arrow_parens='avoid'
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'

" YAML INDENTATION
" autocmd FileType yaml setlocal <buffer> shiftwidth=2
