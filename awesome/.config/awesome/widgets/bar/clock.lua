local wibox = require 'wibox'

local clock = wibox.widget {
    widget = wibox.widget.textclock,
    format = '%H:%M',
}

return clock
