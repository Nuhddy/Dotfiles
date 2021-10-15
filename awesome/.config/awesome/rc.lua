pcall(require, 'luarocks.loader')

local beautiful = require 'beautiful'
local awful = require 'awful'

require 'util.errorhandling'

beautiful.init(awful.util.getdir 'config' .. 'theme.lua')

require 'util.wallpaper'
require 'layouts'
require 'tags'
require 'rules'
require 'util.clientplacement'
require 'awful.autofocus'
require 'keys'

-- titlebars
-- top bar
-- tasklist
-- dashboard
-- popup
-- notifications

-- daemons

-- autostart
