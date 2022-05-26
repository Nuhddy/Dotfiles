local o = vim.o
local opt = vim.opt

local au = vim.api.nvim_create_autocmd

-- Behavior
o.compatible = false
vim.cmd 'filetype plugin indent on'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.hidden = true
o.updatetime = 100
o.timeoutlen = 500
o.wrap = false
o.splitbelow = true
o.splitright = true
o.scrolloff = 0
o.sidescrolloff = 0
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.backupcopy = 'yes'
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Appearance
o.number = false
o.relativenumber = false
o.cursorline = true
o.colorcolumn = '999' -- workaround for indent-blankline + cursorline bug
o.showmode = false
o.pumheight = 10
o.cmdheight = 1
o.laststatus = 3
o.showtabline = 1
opt.shortmess:append { c = true }
o.termguicolors = true
o.background = 'dark'
o.guifont = 'monospace:h17'
vim.cmd 'syntax on'
vim.api.nvim_create_augroup('general_settings', {})
au('TextYankPost', {
    group = 'general_settings',
    pattern = '*',
    command = 'lua vim.highlight.on_yank { on_visual = false }',
})

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

-- Auto-formatting
au({'VimEnter', 'BufEnter'}, {
    group = 'general_settings',
    pattern = '*',
    command = 'lua vim.o.formatoptions = "njtcql"',
})
--[[
n -- indent numbered lists
j -- remove comment leader when joining lines
t -- wrap text using textwidth
c -- wrap comments using textwidth
q -- allow comment formatting
l -- don't wrap long lines if they were too long beforehand
]]

-- Abbreviations
vim.cmd 'cabbrev h vert h'
vim.cmd 'cabbrev H h'
