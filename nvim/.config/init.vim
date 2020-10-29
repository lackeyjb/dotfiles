"==============================================================================
"                              ~ My .vimrc ~
"==============================================================================
set nocompatible " Not compatible with vi

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'wesQ3/vim-windowswap'
Plug 'jiangmiao/auto-pairs'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'elzr/vim-json'

call plug#end()

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

set hidden
set number " Display line numbers
set lazyredraw " Allow buffer change without saving
set updatetime=300 " Don't update while executing macros
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
set completeopt-=preview
set cmdheight=2 " Give more space for displaying messages
set shortmess+=c " Don't pass messages to |ins-completion-menu|
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Theming
" ========
syntax enable
set background=dark
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

" quit help
autocmd Filetype help nmap <buffer> q :q<CR>

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable tabline
let g:airline#extensions#tabline#enabled = 0
" enable powerline fonts
let g:airline_powerline_fonts = 1
" Switch to your current theme
let g:airline_theme = 'dark'
" Always show tabs
set showtabline=2
set t_Co=256

" We don't need to see things like -- INSERT -- anymore
set noshowmode

" Fuzzy file finding
" ====================
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<CR>"
nnoremap <C-g> :Rg<Cr>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" NERDTree
" ========
" let g:NERDTreeShowHidden=1
let g:NERDSpaceDelims = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['.DS_Store', '.idea']
let NERDTreeShowHidden=1

" COC
" ========
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" to extract path from current file's path
map <leader>e :e <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

let g:coc_global_extensions = [
      \ "coc-snippets",
      \ "coc-eslint",
      \ "coc-emmet",
      \ "coc-cssmodules",
      \ "coc-yaml",
      \ "coc-tsserver",
      \ "coc-sql",
      \ "coc-solargraph",
      \ "coc-json",
      \ "coc-html",
      \ "coc-ember",
      \ "coc-css",
      \ "coc-vimlsp",
      \]


" Prettier
" =========
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
let g:prettier#autoformat_config_present = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.rb PrettierAsync

if !exists("*DeleteHiddenBuffers") " Clear all hidden buffers when running
	function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout' buf
		endfor
	endfunction
endif
command! DeleteHiddenBuffers call DeleteHiddenBuffers()
