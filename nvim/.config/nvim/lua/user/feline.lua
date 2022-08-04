-- local palette = require('nightfox.palette.' .. string.format(vim.g.colors_name)).palette

-- List of components
local c = {
    vi_mode = {
        provider = 'vi_mode',
        icon = '',
    },
    file = {
        info = {
            provider = 'file_info',
        },
        enc = {
            provider = 'file_encoding',
        },
    },
    position = {
        provider = 'position',
    },
    line_pct = {
        provider = 'line_percentage',
    },
    lsp = {
        errors = {
            provider = 'diagnostic_errors',
        },
        warnings = {
            provider = 'diagnostic_warnings',
        },
        hints = {
            provider = 'diagnostic_hints',
        },
        info = {
            provider = 'diagnostic_info',
        },
    },
    git_branch = {
        provider = 'git_branch',
        -- icon = '',
        icon = '',
        -- icon = '',
    },
}

local active = {
    { -- left
        c.vi_mode,
        c.git_branch,
        c.file.info,
    },
    { -- right
        c.lsp.errors,
        c.lsp.warnings,
        c.lsp.hints,
        c.lsp.info,
        c.file.enc,
        c.position,
        c.line_pct,
    },
}

local inactive = {
    {}, -- left
    {}, -- right
}

require('feline').setup {
    components = { active = active, inactive = inactive },
    force_inactive = {
        filetypes = {
            'NvimTree',
            'packer',
            'help',
        },
        buftypes = { 'terminal' },
    },
    disable = {
        filetypes = { 'alpha' },
    },
}
