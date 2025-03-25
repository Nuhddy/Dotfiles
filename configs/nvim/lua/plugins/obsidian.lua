return {
    'epwalsh/obsidian.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    ft = 'markdown',
    opts = {
        workspaces = {
            {
                name = 'personal',
                path = '~/Nextcloud/Documents/Obsidian',
            },
        },
    },
}
