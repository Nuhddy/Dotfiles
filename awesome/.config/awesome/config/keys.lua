local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'

local mod = 'Mod4'
local alt = 'Mod1'

local apps = require 'config.apps'

-- Window manager
awful.keyboard.append_global_keybindings {
    awful.key({mod, 'Shift'}, 'r', awesome.restart,
        {description = 'Reload awesome', group = 'System'}),
    awful.key({mod, 'Shift'}, 's', hotkeys_popup.show_help,
        {description = 'Show keybindings', group = 'System'}),
    awful.key({mod}, 'e', function()
            awful.spawn('screenlock.sh')
        end,
        {description = 'Lock workspace', group = 'System'}),
    awful.key({mod, 'Shift'}, 'e', function()
            awful.spawn('powermenu.sh')
        end,
        {description = 'Open power menu', group = 'System'}),
}

-- Tags
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = {mod},
        keygroup    = 'numrow',
        description = 'View tag',
        group       = 'Tag',
        on_press    = function(i)
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end
    },
    awful.key {
        modifiers   = {mod, 'Shift'},
        keygroup    = 'numrow',
        description = 'Move focused client to tag',
        group       = 'Tag',
        on_press    = function(i)
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end
    },
}

-- Client
awful.keyboard.append_global_keybindings {
    awful.key({mod}, 'j', function() awful.client.focus.byidx(1) end,
        {description = 'Focus next client', group = 'Client'}),
    awful.key({mod}, 'k', function() awful.client.focus.byidx(-1) end,
        {description = 'Focus previous client', group = 'Client'}),
    awful.key({alt}, 'Tab', function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Focus previously focused client', group = 'Client'}),
    awful.key({mod, 'Shift'}, 'j', function() awful.client.swap.byidx(1) end,
        {description = 'Swap with next client', group = 'Client'}),
    awful.key({mod, 'Shift'}, 'k', function() awful.client.swap.byidx(-1) end,
        {description = 'Swap with previous client', group = 'Client'}),
}

client.connect_signal('request::default_keybindings', function()
    awful.keyboard.append_client_keybindings {
        awful.key({mod}, 'f', function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'Toggle fullscreen', group = 'Client'}),
        awful.key({mod}, 's', awful.client.floating.toggle,
            {description = 'Toggle floating', group = 'Client'}),
        awful.key({mod, 'Shift'}, 'q', function(c) c:kill() end,
            {description = 'Kill client', group = 'Client'}),
    }
end)

-- Layout
awful.keyboard.append_global_keybindings {
    awful.key({mod}, 'Tab', function() awful.layout.inc(1) end,
        {description = 'Use next layout', group = 'Layout'}),
    awful.key({mod, 'Shift'}, 'Tab', function() awful.layout.inc(-1) end,
        {description = 'Use previous layout', group = 'Layout'}),
    awful.key({mod}, 'l', function() awful.tag.incmwfact(0.05) end,
        {description = 'Increase master width', group = 'Layout'}),
    awful.key({mod}, 'h', function() awful.tag.incmwfact(-0.05) end,
        {description = 'Decrease master width', group = 'Layout'}),
}

-- Launcher
awful.keyboard.append_global_keybindings {
    awful.key({mod}, 'Return', function() awful.spawn(apps.terminal) end,
        {description = 'Open a terminal', group = 'Launcher'}),
    awful.key({mod}, 'space', function() awful.spawn(apps.launcher) end,
        {description = 'Open app launcher', group = 'Launcher'}),
}

-- Backlight
awful.keyboard.append_global_keybindings {
    awful.key({}, 'XF86MonBrightnessUp', function()
            awful.spawn('xbacklight -inc 5')
        end,
        {description = 'Increase brightness', group = 'Brightness'}),
    awful.key({}, 'XF86MonBrightnessDown', function()
            awful.spawn('xbacklight -dec 5')
        end,
        {description = 'Increase brightness', group = 'Brightness'}),
    awful.key({mod}, 'F3', function() awful.spawn('xbacklight -set 100') end,
        {description = 'Increase brightness to 100', group = 'Brightness'}),
    awful.key({mod}, 'F2', function() awful.spawn('xbacklight -set 0') end,
        {description = 'Decrease brightness to 0', group = 'Brightness'}),
}

-- Audio
awful.keyboard.append_global_keybindings {
    awful.key({}, 'XF86AudioMute', function() awful.spawn('pamixer -t') end,
        {description = 'Mute audio', group = 'Audio'}),
    awful.key({}, 'XF86AudioRaiseVolume', function()
            awful.spawn('pamixer -i 5')
        end,
        {description = 'Raise volume', group = 'Audio'}),
    awful.key({}, 'XF86AudioLowerVolume', function()
            awful.spawn('pamixer -d 5')
        end,
        {description = 'Lower volume', group = 'Audio'}),
}

-- Music player
awful.keyboard.append_global_keybindings {
    awful.key({}, 'XF86AudioPlay', function()
            awful.spawn('playerctl-specific-player.sh ' ..
                    apps.musicplayer .. 'play-pause')
        end,
        {description = 'Play/pause', group = 'Media'}),
    awful.key({}, 'XF86AudioNext', function()
            awful.spawn('playerctl-specific-player.sh ' ..
                    apps.musicplayer .. 'next')
        end,
        {description = 'Next track', group = 'Media'}),
    awful.key({}, 'XF86AudioPrev', function()
            awful.spawn('playerctl-specific-player.sh ' ..
                    apps.musicplayer .. 'prev')
        end,
        {description = 'Previous track', group = 'Media'}),
}

-- Misc
awful.keyboard.append_global_keybindings {
    awful.key({mod}, 't', function() awful.spawn('toggletray.sh') end,
        {description = 'Toggle tray', group = 'Misc'}),
    awful.key({mod, 'Shift'}, 'm', function()
            awful.spawn('toggletouchpad.sh')
        end,
        {description = 'Toggle tray', group = 'Misc'}),
    awful.key({mod}, 'Print', function() awful.spawn('screenshotmenu.sh') end,
        {description = 'Toggle tray', group = 'Misc'}),
}

-- Mouse
awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
            c:activate {context = 'mouse_click'}
        end),
    awful.button({mod}, 1, function(c)
            c:activate {context = 'mouse_click', action = 'mouse_move'}
        end),
    awful.button({mod}, 3, function(c)
            c:activate {context = 'mouse_click', action = 'mouse_resize'}
        end),
}
