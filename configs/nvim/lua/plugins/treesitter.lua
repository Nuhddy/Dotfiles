return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        --[[ Auto install grammar for current filetype.
        Needs tree-sitter cli installed locally. ]]
        auto_install = true,
        -- Only needed if auto install does not work
        ensure_installed = {
            'comment',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        -- TODO: what the hell is this
        -- autopairs = { enabled = true },
        --[[ context_commentstring = {
            enable = true,
            enable_autocmd = false,
        }, ]]
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
