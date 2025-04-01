local function obs_path(sub_dir)
    local root_dir

    if _G.OS == 'WSL' then
        root_dir = '/mnt/c/Users/'
            .. vim.loop.os_getenv 'USER' ---@diagnostic disable-line
            .. '/Nextcloud/Documents/Obsidian/'
    elseif _G.OS == 'Windows' then
        root_dir = 'C:\\Users\\'
            .. vim.loop.os_getenv 'USER' ---@diagnostic disable-line
            .. '\\Nextcloud\\Documents\\Obsidian\\'
    else
        root_dir = '~/Nextcloud/Documents/Obsidian/'
    end

    return root_dir .. sub_dir
end

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
                path = obs_path 'Workouts',
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
