return {
    'glacambre/firenvim',
    lazy = not vim.g.started_by_firenvim,
    build = ':call firenvim#install(0)',
    config = function()
        if vim.g.started_by_firenvim == true then
            vim.o.laststatus = 0
        end

        vim.g.firenvim_config = {
            globalSettings = { alt = 'all' },
            localSettings = {
                ['.*'] = {
                    cmdline = 'neovim',
                    content = 'text',
                    priority = 0,
                    selector = 'textarea',
                    takeover = 'never',
                },
            },
        }
    end,
}
