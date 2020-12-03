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
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

" js / web standards
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'herringtondarkholme/yats.vim', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'html', 'css', 'json'] }
Plug 'elzr/vim-json', { 'for': 'json' }

" python
Plug 'psf/black', { 'for': 'python', 'tag': '19.10b0' }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }  " can CoC do it?
Plug 'cespare/vim-toml'

call plug#end()

" da basics
filetype plugin indent on
syntax on
set expandtab " use spaces instead of tabs.

" tagbar
let g:tagbar_sort = 0 " hate that this isn't a default...
let g:tagbar_width = 50
let g:tagbar_zoomwidth = 0
let g:tagbar_autofocus = 1

let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'javascript',
    \ 'kinds'     : [
        \ 'A:Arrays',
        \ 'C:Classes',
        \ 'E:Exports',
        \ 'F:Functions',
        \ 'G:Generators',
        \ 'I:Imports',
        \ 'M:Methods',
        \ 'P:Properties',
        \ 'S:StyledComponents',
        \ 'T:Tags',
        \ 'V:Variables'
    \ ]
    \ }

" bufkill
let g:BufKillCreateMappings=0

" mappings
let mapleader=' '

inoremap jj <Esc>
cnoremap jj <Esc>
" exit terminal
tnoremap <C-g> <C-\><C-n>  

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

" maps to K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc maps
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>n <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList --auto-preview outline<cr>
nnoremap <silent><nowait> <space>y  :<C-u>CocList yank<cr>
nnoremap <silent><nowait> <space>a  :<C-u>CocAction<cr>
nnoremap <silent><nowait> <space>pyi  :<C-u>CocCommand python.setInterpreter<cr>
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]a <Plug>(coc-diagnostic-next)
nmap <silent> [a <Plug>(coc-diagnostic-prev)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" more coc [https://github.com/neoclide/coc.nvim#example-vim-configuration]
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set updatetime=300
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


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
let g:FerretAutojump=0

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

" prettier
let g:prettier#config#arrow_parens='avoid'
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
