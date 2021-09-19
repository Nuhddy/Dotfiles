-- Global abbreviated vars
g = vim.g     -- access global vars
o = vim.o     -- global options
fn = vim.fn   -- call vim functions
cmd = vim.cmd -- execute vim commands

-- Modules
require 'plugins'
require 'opts'
require 'keys'

-- Vimscript leftovers
cmd([[
" Use css syntax highlighting for rofi .rasi files
autocmd BufNewFile,BufRead *.rasi set syntax=css

" Open help in vsplit
cabbrev vh vert h

" TERMINAL
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

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
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''

" NERDTREE
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
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

" EMMET
let g:user_emmet_install_global = 0
autocmd FileType html,css,htmldjango,xml EmmetInstall

" ALE LINTING
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

" PANDOC MARKDOWN
augroup pandoc_markdown
    au! BufNewFile,BufFilePre,BufRead *.pdc set filetype=markdown.pandoc textwidth=79
augroup END
let g:pandoc#syntax#conceal#use = 0
]])
--[[ s:IsFirenvimActive(event) shows error message when run inside vim.cmd

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

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
]]
