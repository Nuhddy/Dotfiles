local g = vim.g
local cmd = vim.cmd

-- colorizer
require('colorizer').setup()

-- gitsigns
require('gitsigns').setup()

-- better whitespace
g.better_whitespace_enabled = 1
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 1

-- nerdcommenter
g.NERDSpaceDelims = 1
g.NERDCommentEmptyLines = 1
g.NERDTrimTrailingWhitespace = 0

-- emmet
g.user_emmet_install_global = 0
cmd 'au FileType html,css,xml EmmetInstall'

-- ale
g.ale_lint_on_enter = 0
g.ale_sign_error = '✘'
g.ale_sign_warning = ''

-- markdown preview
g.mkdp_command_for_global = 1
g.mkdp_page_title = '${name}'

-- pandoc syntax
g['pandoc#syntax#conceal#use'] = 0
