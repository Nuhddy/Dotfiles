local M = {}

M.keymap_set = function(mode, lhs, rhs, opts, default_opts)
    if opts then
        opts = vim.tbl_extend('force', default_opts, opts)
    else
        opts = default_opts
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
