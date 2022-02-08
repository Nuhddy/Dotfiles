local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
    return
end

local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
    dashboard.button('e', '  New file', ':ene | startinsert<CR>'),
    dashboard.button('f', '  Open file', ':Telescope find_files<CR>'),
    dashboard.button('p', '  Open project', ':Telescope projects<CR>'),
    dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
    dashboard.button('t', '  Find text', ':Telescope live_grep<CR>'),
    dashboard.button(
        'c',
        '  Configuration',
        ':cd ~/.config/nvim/ | :e init.lua<CR>'
    ),
    dashboard.button('q', '  Quit neovim', ':qa<CR>'),
}

alpha.setup(dashboard.opts)
