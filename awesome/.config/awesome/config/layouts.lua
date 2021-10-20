local awful = require 'awful'

local l = awful.layout.suit

tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts {
        l.max,
        l.tile.right,
    }
end)
