local c = require 'colors'

local theme = {
    normal = {
        a = {fg = c.blue, bg = c.dark2},
        b = {fg = c.light1, bg = c.dark2},
        c = {fg = c.light1, bg = c.dark1},
    },

    insert = {a = {fg = c.green, bg = c.dark2}},
    visual = {a = {fg = c.orange, bg = c.dark2}},
    replace = {a = {fg = c.red, bg = c.dark2}},
    command = {a = {fg = c.pink, bg = c.dark2}},

    inactive = {
        a = { fg = c.light1, bg = c.dark2 },
        b = { fg = c.light1, bg = c.dark1 },
        c = { fg = c.dark1, bg = c.dark1 },
    },
}

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.modified,
            removed = gitsigns.removed,
        }
    end
end

require('lualine').setup {
    options = {
        theme = theme,
        color = {gui = 'bold'},
        section_separators = {left = '', right = ''},
        component_separators = '',
    },
    sections = {
        lualine_a = {
            {'mode', separator = {left = ''}, color = {gui = 'bold'}},
        },
        lualine_b = {
            {'filetype', icon_only = true},
            {'filename', path = 1, padding = {left = 0, right = 1}},
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {'b:gitsigns_head', icon = ''},
            {'diff', source = diff_source, padding = 0},
        },
        lualine_z = {
            {'location', color = {fg = c.light1, bg = c.dark2}},
            {
                'progress', separator = {right = ''},
                color = {fg = c.light1, bg = c.dark2}
            },
        },
    },
    inactive_sections = {
        lualine_a = {
            {'filename', path = 1, separator = {left = '', right = ''}}
        },
    }
}
