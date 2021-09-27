local gl = require 'galaxyline'
local gls = gl.section

local condition = require 'galaxyline.condition'

local fileinfo = require 'galaxyline.provider_fileinfo'
local vcs = require 'galaxyline.provider_vcs'

gl.short_line_list = { 'packer', 'NvimTree' }

local colors = {
    dark1   = '#161616',
    dark2   = '#222222',
    dark3   = '#444444',
    dark4   = '#666666',
    light4  = '#cccccc',
    light3  = '#dddddd',
    light2  = '#d5d5d5',
    light1  = '#e5e5e5',
    red     = '#d23d3d',
    orange  = '#eb8413',
    yellow  = '#fea63c',
    green   = '#379e4d',
    cyan    = '#6d878d',
    blue    = '#66a9b9',
    pink    = '#b7416e',
    brown   = '#c85e0d',
}

-- Helpers
local Sections = {
    left = 0,
    center = 0,
    right = 0
}

local function add_section(place, opts)
    if place == 'l' then
        local i = Sections.left
        gl.section.left[i + 1] = opts
        Sections.left = Sections.left + 1
    elseif place == 'c' then
        local i = Sections.center
        gl.section.center[i + 1] = opts
        Sections.center = Sections.center + 1
    elseif place == 'r' then
        local i = Sections.right
        gl.section.right[i + 1] = opts
        Sections.right = Sections.right + 1
    end
end

local function get_mode_opts()
    local mode_map = {
        [110] = { 'NORMAL',     colors.blue },
        [105] = { 'INSERT',     colors.green },
        [99] =  { 'COMMAND',    colors.blue },
        [116] = { 'TERMINAL',   colors.green },
        [118] = { 'VISUAL',     colors.pink },
        [22] =  { 'V-BLOCK',    colors.pink },
        [86] =  { 'V-LINE',     colors.pink },
        [82] =  { 'REPLACE',    colors.red },
        [115] = { 'SELECT',     colors.red },
        [83] =  { 'S-LINE',     colors.red },
    }
    local mode = vim.fn.mode():byte()
    local label = mode_map[mode][1]
    local color = mode_map[mode][2]
    return { label, color }
end

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    else
        return false
    end
end

-- Sections
-- Left
add_section('l', {
    ViModeSepLeft = {
        provider = function()
            local color = get_mode_opts()[2]
            vim.cmd('hi GalaxyViModeSepLeft guifg=' .. color)
            return ''
        end,
    }
})

add_section('l', {
    ViMode = {
        provider = function()
            local label = get_mode_opts()[1]
            local color = get_mode_opts()[2]
            vim.cmd('hi GalaxyViMode guibg=' .. color
                    .. ' guifg=' .. colors.dark1)
            return label
        end,
        highlight = { colors.dark1, colors.dark1, 'bold' },
    }
})

add_section('l', {
    ViModeSepRight = {
        provider = function()
            local color = get_mode_opts()[2]
            vim.cmd('hi GalaxyViModeSepRight guifg=' .. color)
            return ''
        end,
        highlight = { colors.dark2, colors.dark2 },
    }
})

add_section('l', {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = { fileinfo.get_file_icon_color, colors.dark2 },
    }
})

add_section('l', {
    FileName = {
        provider = 'FileName',
        highlight = { colors.light1, colors.dark2 },
    }
})

-- Right
add_section('r', {
    GitIcon = {
        provider = function() return '' end,
        condition = vcs.check_git_workspace,
        highlight = { colors.orange, colors.dark2 },
    }
})

add_section('r', {
    GitBranch = {
        provider = 'GitBranch',
        condition = vcs.check_git_workspace,
        highlight = { colors.light1, colors.dark2 },
    }
})

add_section('r', {
    DiffAdd = {
        provider = 'DiffAdd',
        highlight = { colors.green, colors.dark2 },
        icon = '+',
    }
})

add_section('r', {
    DiffModified = {
        provider = 'DiffModified',
        highlight = { colors.blue, colors.dark2 },
        icon = '~',
    }
})

add_section('r', {
    DiffRemove = {
        provider = 'DiffRemove',
        highlight = { colors.red, colors.dark2 },
        icon = '-',
    }
})

add_section('r', {
    LineInfo = {
        provider = 'LineColumn',
        highlight = { colors.light1, colors.dark2 },
    }
})

-- Short statusline
gls.short_line_left[1] = {
    FileName = {
        provider = 'FileName',
        highlight = { colors.light1, colors.dark2 },
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
