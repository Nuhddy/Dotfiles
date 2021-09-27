local o = vim.o
local cmd = vim.cmd

-- Behavior
vim.g.mapleader = ','
o.compatible = false
cmd 'filetype plugin indent on'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.hidden = true
o.updatetime = 100
o.wrap = false
o.splitbelow = true
o.splitright = true
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.backupcopy = 'yes'

-- Appearance
o.number = false
o.relativenumber = false
o.cursorline = true
o.colorcolumn = "999" -- workaround for indent-blankline + cursorline bug
o.showmode = false
o.pumheight = 10
o.cmdheight = 1
cmd 'syntax on'
cmd 'au TextYankPost * lua vim.highlight.on_yank { on_visual = false }'
o.termguicolors = true
o.background = 'dark'
cmd 'colorscheme flavours'

-- Searching
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = false
o.iskeyword = o.iskeyword .. ',-'

-- Indentation
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true
o.autoindent = true -- dependency for o.formatoptions = 'n'

-- Auto-completion
--[[
   [ cmd 'au BufEnter * call ncm2#enable_for_buffer()'
   [ o.completeopt = 'noinsert,menuone,noselect'
   [ o.shortmess = o.shortmess .. 'c'
   ]]

-- Auto-formatting
cmd 'au VimEnter,BufEnter * lua vim.o.formatoptions = "njtcql"'
--[[
   [ o.formatoptions = '' -- doesn't work outside au
   [         .. 'n' -- indent numbered lists
   [         .. 'j' -- remove comment leader when joining lines
   [         .. 't' -- wrap text using textwidth
   [         .. 'c' -- wrap comments using textwidth
   [         .. 'q' -- allow comment formatting
   [         .. 'l' -- don't wrap long lines if they were too long beforehand
   ]]

-- Abbreviations
cmd 'cabbrev h vert h'
cmd 'cabbrev H h'
