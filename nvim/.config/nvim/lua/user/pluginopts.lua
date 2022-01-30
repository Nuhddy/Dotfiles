local g = vim.g
local cmd = vim.cmd

local colors = require 'user.colors'

-- Colorscheme
require('flavours').setup {
    colors = colors,
    italic_comments = false,
}

-- Colorizer
require('colorizer').setup()

-- IndentBlankLine highlight group
cmd('hi IndentBlanklineIndent1 guifg=' .. colors.dark3 .. ' gui=nocombine')

-- Whitespace trimmer
g.better_whitespace_enabled = 0
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 1

-- Emmet
g.user_emmet_install_global = 0
cmd 'au FileType html,css,xml EmmetInstall'

-- Markdown live-preview
g.mkdp_command_for_global = 1
g.mkdp_page_title = '${name}'

-- Pandoc syntax
g['pandoc#syntax#conceal#use'] = 0
