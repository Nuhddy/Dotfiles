local awful = require 'awful'

local tasklist = {}

tasklist.init = function(s)
    return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate {context = 'tasklist'}
            end)
        },
    }
end

return tasklist
