return {
    'epwalsh/obsidian.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    ft = 'markdown',
    opts = {
        workspaces = {
            {
                name = 'Workouts',
                path = '~/Nextcloud/Documents/Obsidian/Workouts',
                overrides = {
                    disable_frontmatter = true,
                    templates = {
                        folder = 'Templates',
                        date_format = '%Y-%m-%d',
                    },
                    note_id_func = function()
                        return tostring(os.date '%Y-%m-%d')
                    end,
                },
            },
        },
    },
}
