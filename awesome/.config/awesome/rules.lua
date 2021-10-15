local ruled = require 'ruled'
-- local beautiful = require 'beautiful'
local awful = require 'awful'

ruled.client.connect_signal('request::rules', function()

    -- Global rule
    ruled.client.append_rule {
        id = 'global',
        rule = {},
        properties = {
            -- border_color = beautiful.border_color_normal,
            -- border_width = beautiful.border_width,
            focus = awful.client.focus.filter,
            placement = awful.placement.no_overlap +
                    awful.placement.no_offscreen,
            raise = true,
            screen = awful.screen.preferred,
            size_hints_honor = false,
        }
    }

    -- Start as floating
    ruled.client.append_rule {
        id = 'floating',
        rule_any = {
            instance = {},
            class = {},
            name = {},
            role = {},
        },
        properties = {floating = true}
    }

    -- Add titlebars
    --[[ ruled.client.append_rule {
        id = 'titlebars',
        rule_any = {type = 'dialog'},
        properties = {titlebars_enabled = true}
    } ]]

end)
