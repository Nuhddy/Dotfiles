local M = {}

M.set_mappings = function(map_table, opts)
    for mode, maps in pairs(map_table) do
        for keys, rhs in pairs(maps) do
            local cmd = rhs
            if type(rhs) == "table" then
                cmd = rhs[1]
                rhs[1] = nil
                opts = vim.tbl_deep_extend("force", opts, rhs)
            end
            vim.keymap.set(mode, keys, cmd, opts)
        end
    end
end

M.cmp_add_source = function(source)
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then return end

    local config = cmp.get_config()
    table.insert(config.sources, source)
    cmp.setup(config)
end

return M
