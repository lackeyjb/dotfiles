set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"==============================================================================
"                              ~ My .vimrc ~
"==============================================================================
set nocompatible " Not compatible with vi

let g:ale_emit_conflict_warnings = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\ }
let g:ale_linters = {
\  'typescript': ['tsserver', 'eslint'],
\  'go': ['gopls', 'golangci-lint'],
\ }
let g:ale_go_golangci_lint_options = '--fast'
let g:ale_go_golangci_lint_package = 1
let g:ale_fix_on_save = 1

let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

call plug#begin()

 Plug '/usr/local/opt/fzf'
 Plug 'junegunn/fzf.vim'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-commentary'
 Plug 'altercation/vim-colors-solarized'
 Plug 'airblade/vim-gitgutter'
 Plug 'raimondi/delimitmate'
 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-fugitive'
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'Yggdroot/indentLine'
 Plug 'jistr/vim-nerdtree-tabs'
 Plug 'wesQ3/vim-windowswap'
 Plug 'w0rp/ale'
 Plug 'crusoexia/vim-dracula'
 Plug 'morhetz/gruvbox'
 Plug 'ryanoasis/vim-devicons'
 Plug 'elzr/vim-json'
 Plug 'itchyny/lightline.vim'
 Plug 'maximbaz/lightline-ale'
 Plug 'HerringtonDarkholme/yats.vim'
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'mhartington/nvim-typescript', { 'do': './install.sh'}
 Plug 'leafgarland/typescript-vim'
 Plug 'Shougo/vimproc.vim', {'do' : 'make'}
 Plug 'othree/csscomplete.vim'
 Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
 Plug 'davidhalter/jedi-vim'
 Plug 'zchee/deoplete-jedi'

call plug#end()

" CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" Easy access to start of line
nmap 0 ^
" Move through wrapped lines
nmap k gk
nmap j gj

" set leader
let mapleader = "\<Space>"

" Open & source vimrc
nmap <leader>vi :tabe $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" Display whitespace
set list listchars=tab:\|\ ,trail:·,nbsp:·

" Edit another file in the same directory as the current file uses expression
" to extract path from current file's path
map <leader>e :e <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" to escape
imap jk <esc>
imap kj <esc>

" new tab
map <C-t> <esc>:tabnew<CR>

" setup the mouse
set clipboard=unnamed
set ttyfast
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

" Display line numbers
set hidden
set number
" Allow buffer change without saving
set lazyredraw
" Don't update while executing macros
set updatetime=250
set encoding=UTF-8
set backspace=indent,eol,start "Sane backspace behavior
set history=50
set scrolloff=4
set nobackup
set nowritebackup
set noswapfile
set laststatus=2
set autowrite
set autoread
set backspace=2
set colorcolumn=80
set expandtab
set tabstop=2
set conceallevel=0
set shiftwidth=2
set softtabstop=2
set ruler
set noshowmode
set ignorecase
set smartcase

" vim theme
syntax enable
set background=dark
" colorscheme solarized
" colorscheme dracula
" let g:dracula_italic = 1
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
" see the cursor better
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" let g:NERDTreeShowHidden=1
let g:NERDSpaceDelims = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['.DS_Store']

" For jsx syntax
let g:jsx_ext_required = 0

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.jbuilder set ft=ruby

" quit help
autocmd Filetype help nmap <buffer> q :q<CR>

autocmd BufWritePre * %s/\s\+$//e

" JSON
let g:vim_json_syntax_conceal = 0

" Lightline Status
let g:lightline = {}

let g:lightline.component_function = {
      \   'gitbranch': 'fugitive#head'
      \ }
let g:lightline.component_expand = {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ }
let g:lightline.active = {
      \   'left': [['mode', 'paste'],
      \            ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'],
      \             [ 'linter_checking', 'linter_errors',
      \               'linter_warnings', 'linter_ok' ]]
      \ }

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>unction

let g:gtm_plugin_status_enabled = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Prettier autosave
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yml PrettierAsync

" TypeScript
let g:nvim_typescript#default_mappings = 1

set completeopt-=preview

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
