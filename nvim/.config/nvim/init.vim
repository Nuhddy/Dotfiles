" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'yggdroot/indentline'
Plug 'glacambre/firenvim', {'do': {_ -> firenvim#install(0)}}
Plug 'tridactyl/vim-tridactyl', {'for': 'tridactyl'}
Plug 'mboughaba/i3config.vim', {'for': 'i3config'}
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'}
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()},
            \ 'for': ['markdown', 'markdown.pandoc', 'vim-plug']}
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'cespare/vim-toml'
Plug 'dense-analysis/ale'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi', {'for': 'python'}
Plug 'observeroftime/ncm2-jc2', {'for': ['java', 'jsp']}
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}
call plug#end()

" GENERAL
let mapleader=","
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set fileencoding=utf-8
set hidden
set number relativenumber
set nowrap
set noshowmode
set ignorecase
set smartcase
set incsearch
set nohlsearch
set iskeyword+=-
set splitbelow splitright
set updatetime=100
set termguicolors
set t_Co=256
set background=dark
colorscheme flavours
set pumheight=10
set cmdheight=1
set mouse=a
set clipboard+=unnamedplus

" Disable auto-commenting on line break
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Find temporary mark
inoremap <leader><leader> <ESC>/<++><CR>"_c4l

" Swap, backup, and undo file location
set directory=~/.tmp/nvimtmp//
set backupdir=~/.tmp/nvimtmp//
set undodir=~/.tmp/nvimtmp//
set backupcopy=yes

" Edit and source init.vim anywhere
nnoremap <leader>ec :vsp $MYVIMRC<CR>
nnoremap <leader>sc :source $MYVIMRC <bar> :doautocmd BufRead<CR>
au! BufWritePost $MYVIMRC source $MYVIMRC

" Use css syntax highlighting for rofi .rasi files
autocmd BufNewFile,BufRead *.rasi set syntax=css

" Open help in vsplit
cabbrev h vert h

" INDENTATION
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" TERMINAL
tnoremap <ESC> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" SPELL CHECK
map <leader>od :setlocal spell! spelllang=da<CR>
map <leader>oe :setlocal spell! spelllang=en<CR>

" AIRLINE
let g:airline_skip_empty_sections = 1

" Airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" Tabline symbols
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''

" GOYO
map <leader>go :Goyo<CR>

" TAGBAR
nmap <leader>t :TagbarToggle<CR>

" NERDTREE
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
            \ && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

" NERDCOMMENTER
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 0

" BETTER WHITESPACE
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 1

" COLORIZER
lua require 'colorizer'.setup()

" GITGUTTER
let g:gitgutter_enabled = 0
map <leader>gg :GitGutterToggle<CR>

" FUGITIVE
map <leader>gw :Gwrite<CR>
map <leader>gc :Gcommit<space>%<CR>
map <leader>gs :GStatus<CR>

" EMMET
let g:user_emmet_install_global = 0
autocmd FileType html,css,htmldjango,xml EmmetInstall

" ALE LINTING
nmap <silent> <C-e> <Plug>(ale_next_wrap)
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
let g:airline#extensions#ale#enabled = 1

" MARKDOWN PREVIEW
augroup markdown
    au! BufEnter *.md set textwidth=79
augroup END
let g:mkdp_command_for_global = 1
let g:mkdp_page_title = '${name}'
nmap <leader>mp <Plug>MarkdownPreviewToggle

" PANDOC MARKDOWN
augroup pandoc_markdown
    au! BufNewFile,BufFilePre,BufRead *.pdc set filetype=markdown.pandoc
                \ textwidth=79
augroup END
let g:pandoc#syntax#conceal#use = 0
nmap <F5> :!pandoc -f markdown -t pdf %<CR><CR>

" LATEX MACROS
inoremap <leader>infer1 \infer[<++>]<CR><TAB>{<++>}<CR>{<++>}<CR><BACKSPACE>
            \ <ESC>3k0i
inoremap <leader>infer2 \infer[<++>]<CR><TAB>{<++>}<CR>{<++> &<CR><++>}<CR>
            \ <BACKSPACE><ESC>4k0i
inoremap <leader>infer3 \infer[<++>]<CR><TAB>{<++>}<CR>{<++> &<CR><++> &<CR>
            \ <++>}<CR><BACKSPACE><ESC>5k0i

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" FIRENVIM
function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set laststatus=0
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
