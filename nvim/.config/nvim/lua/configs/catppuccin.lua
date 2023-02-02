require("catppuccin").setup {
    flavour = "mocha",
    no_italic = true,
    -- https://github.com/catppuccin/nvim#integrations
    integrations = {
        indent_blankline = { enabled = true },
        mason = true,
        neotree = true,
        cmp = true,
        native_lsp = { enabled = true },
        treesitter = true,
    },
}

vim.cmd.colorscheme "catppuccin"
