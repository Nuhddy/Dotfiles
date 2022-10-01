local M = {}

M.keymap_set = function(mode, lhs, rhs, opts, default_opts)
    if opts then
        opts = vim.tbl_extend('force', default_opts, opts)
    else
        opts = default_opts
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.telescope_project_files = function()
    local t = require 'telescope.builtin'
    local opts = {}
    local ok = pcall(t.git_files, opts)
    if not ok then
        t.find_files(opts)
    end
end

return M
