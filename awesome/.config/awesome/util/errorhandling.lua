local naughty = require 'naughty'

naughty.connect_signal('require::display_error', function(message, startup)
    naughty.notification {
        urgency = 'critical',
        title = 'An error happened' .. (startup and ' during startup' or ''),
        message = message
    }
end)
