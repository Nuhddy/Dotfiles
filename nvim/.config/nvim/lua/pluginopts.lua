local g = vim.g
local cmd = vim.cmd

local colors = require 'colors'

-- Colorscheme
require('flavours').setup {
    colors = colors,
}

-- Completion
local cmp = require 'cmp'
cmp.setup {
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
    },
    sources = {
        {name = 'buffer'},
        {name = 'path'},
        {name = 'nvim_lua'},
        {name = 'nvim_lsp'},
    }
}

-- Colorizer
require('colorizer').setup()

-- Gitsigns
require('gitsigns').setup {
    signcolumn = false,
}

-- File explorer
require('nvim-tree').setup {
    auto_close = true,
}

-- Show indentation
cmd('hi IndentBlanklineIndent1 guifg=' .. colors.dark3 .. ' gui=nocombine')

require('indent_blankline').setup {
    char = '¦',
    char_highlight_list = {'IndentBlanklineIndent1'},
    buftype_exclude = {'terminal', 'help'},
}

-- Whitespace trimmer
g.better_whitespace_enabled = 0
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 1

-- Commenter
g.NERDSpaceDelims = 1
g.NERDCommentEmptyLines = 1
g.NERDTrimTrailingWhitespace = 0

-- Emmet
g.user_emmet_install_global = 0
cmd 'au FileType html,css,xml EmmetInstall'

-- Markdown live-preview
g.mkdp_command_for_global = 1
g.mkdp_page_title = '${name}'

-- Pandoc syntax
g['pandoc#syntax#conceal#use'] = 0
