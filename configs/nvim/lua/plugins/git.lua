return {
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '-' }, -- FIXME: underscore but on top
            changedelete = { text = '~' },
        },
    },
}
