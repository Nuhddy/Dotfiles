local cmd = vim.cmd

-- Modules
require 'plugins'       -- lua/plugins.lua
require 'opts'          -- lua/opts.lua
require 'pluginopts'    -- lua/pluginopts.lua
require 'keys'          -- lua/keys.lua
require 'statusline'    -- lua/statusline.lua

cmd 'source ~/.config/nvim/vim/firenvim.vim'

--[[

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
]]
