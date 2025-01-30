return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        no_italic = true,
        -- INFO: https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
        integrations = {
            markdown = true,
        },
    },
    config = function(_, opts)
        require('catppuccin').setup(opts)
        vim.cmd.colorscheme 'catppuccin'
    end,
}
