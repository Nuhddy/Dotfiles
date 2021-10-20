local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'

local launcher = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.awesome_icon,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn(require('config.apps').launcher)
        end)
    },
}

return launcher
