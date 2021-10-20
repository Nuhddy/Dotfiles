local awful = require 'awful'
local wibox = require 'wibox'

-- Widgets
-- local dashboard = require 'widgets.bar.dashboard'
local launcher = require 'widgets.bar.launcher'
local taglist = require 'widgets.bar.taglist'
local layoutbox = require 'widgets.bar.layoutbox'
local tasklist = require 'widgets.bar.tasklist'
-- local systray = require 'widgets.bar.systray'
-- local network = require 'widgets.bar.network'
-- local audio = require 'widgets.bar.audio'
-- local battery = require 'widgets.bar.battery'
local clock = require 'widgets.bar.clock'

-- Bar setup
screen.connect_signal('request::desktop_decoration', function(s)

    -- Widget init
    local taglist_init = taglist.init(s)
    local layoutbox_init = layoutbox.init(s)
    local tasklist_init = tasklist.init(s)

    -- Bar setup
    s.bar = awful.wibar {
        screen = s,
        position = 'bottom',
        height = 27,
        type = 'dock',
    }

    -- Widget setup
    s.bar.widget = {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            -- dashboard,
            launcher,
            taglist_init,
            layoutbox_init,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            tasklist_init,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            -- systray,
            -- network,
            -- audio,
            -- battery,
            clock,
        }
    }
end)
