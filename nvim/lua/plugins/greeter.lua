return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        dashboard.section.buttons.val = {
            dashboard.button('e', 'New file', '<cmd>enew<cr>'),
            dashboard.button('f', 'Find file', '<cmd>Telescope find_files<cr>'),
            dashboard.button(
                'r',
                'Recent files',
                '<cmd>Telescope oldfiles<cr>'
            ),
            dashboard.button(
                's',
                'Settings',
                '<cmd>edit $MYVIMRC | cd %:p:h<cr>'
            ),
            dashboard.button('q', 'Quit', '<cmd>quitall<cr>'),
        }

        alpha.setup(dashboard.opts)
    end,
}
