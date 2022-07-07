require('nightfox').setup {
    groups = {
        all = {
            IndentBlanklineIndent1 = { fg = 'bg2', style = 'nocombine' },
        },
    },
}

vim.cmd 'colorscheme nordfox'
