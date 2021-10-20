pcall(require, 'luarocks.loader')

local beautiful = require 'beautiful'
local awful = require 'awful'

require 'util.errorhandling'

beautiful.init(awful.util.getdir 'config' .. 'theme.lua')

require 'config.layouts'
require 'config.tags'
require 'config.rules'
require 'config.keys'

require 'util.clientplacement'
require 'awful.autofocus'

require 'widgets.bar'
-- titlebars
-- dashboard
-- popup
-- notifications

-- daemons

-- autostart
