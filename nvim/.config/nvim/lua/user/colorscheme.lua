require('nightfox').setup {
    compile_path = vim.fn.stdpath('cache') .. '/nightfox',
    groups = {
        all = {
            IndentBlanklineIndent1 = {
                fg = 'palette.bg2',
                style = 'nocombine',
            },
            IncSearch = { bg = 'palette.blue' },
        },
    },
}

vim.cmd 'colorscheme nordfox'
