local g = vim.g
local o = vim.o
local cmd = vim.cmd

-- Completion
local cmp = require 'cmp'
o.completeopt = 'menu,menuone,noselect'
cmp.setup {
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {select = true},
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
require('gitsigns').setup()

-- File explorer
require('nvim-tree').setup()

-- Show indentation
require('indent_blankline').setup {
    buftype_exclude = { 'terminal', 'help' }
}

-- Whitespace trimmer (redundant?)
g.better_whitespace_enabled = 1
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 1

-- Commenter
g.NERDSpaceDelims = 1
g.NERDCommentEmptyLines = 1
g.NERDTrimTrailingWhitespace = 0

-- Emmet
g.user_emmet_install_global = 0
cmd 'au FileType html,css,xml EmmetInstall'

-- Linter (redundant?)
g.ale_lint_on_enter = 0
g.ale_sign_error = '✘'
g.ale_sign_warning = ''

-- Markdown live-preview
g.mkdp_command_for_global = 1
g.mkdp_page_title = '${name}'

-- Pandoc syntax
g['pandoc#syntax#conceal#use'] = 0
