local M = {}

M.set_opts = function(options)
    for scope, settings in pairs(options) do
        for setting, value in pairs(settings) do
            vim[scope][setting] = value
        end
    end
end

return M
