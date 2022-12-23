local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
    return
end

local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
    dashboard.button(
        'e',
        '  New file',
        '<cmd>enew | startinsert<CR>',
        {}
    ),
    dashboard.button(
        'o',
        '  Open file',
        -- '<cmd>lua require("user.lib.utils").telescope_project_files()<CR>',
        '<cmd>Telescope find_files<CR>',
        {}
    ),
    --[[ dashboard.button(
        'p',
        '  Open project',
        '<cmd>Telescope projects<CR>',
        {}
    ), ]]
    dashboard.button(
        'r',
        '  Recent files',
        '<cmd>Telescope oldfiles<CR>',
        {}
    ),
    -- dashboard.button('f', '  Find text', '<cmd>Telescope live_grep<CR>', {}),
    dashboard.button(
        'c',
        '  Configuration',
        '<cmd>cd ~/.config/nvim/ | e init.lua<CR>',
        {}
    ),
    dashboard.button('q', '  Quit neovim', '<cmd>qa<CR>', {}),
}

alpha.setup(dashboard.opts)
