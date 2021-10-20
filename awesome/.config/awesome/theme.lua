local rnotification = require 'ruled.notification'
local xresources = require 'beautiful.xresources'
local c = require 'config.colors'

-- Temp
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local dpi = xresources.apply_dpi

local theme = {}

-- Colors
-- -- Global
theme.bg_normal = '#00000000'
theme.fg_normal = c.light3

-- -- Bar
theme.wibar_bg = '#00000088'

-- -- Tasklist
theme.tasklist_bg_focus = '#ffffff16'
theme.tasklist_bg_urgent = '#ff880033'

-- -- Border
theme.border_color_normal = c.dark3
theme.border_color_active = c.blue

-- Borders & gaps
theme.border_width = dpi(1)
theme.useless_gap = dpi(6)

-- Font
theme.font = 'sans 10'

-- Icons
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_tile = themes_path .. 'default/layouts/tilew.png'

-- Notifications
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule = {urgency = 'critical'},
        properties = {bg = c.red, fg = c.light3},
    }
end)

return theme
