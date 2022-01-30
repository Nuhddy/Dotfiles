local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local d = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local f = null_ls.builtins.formatting

null_ls.setup {
    debug = false,
    sources = {
        -- lua
        f.stylua,

        -- python
        f.black,
        d.flake8,
    },
}
