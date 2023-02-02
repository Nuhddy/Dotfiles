local null_ls = require "null-ls"

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local d = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local f = null_ls.builtins.formatting

null_ls.setup {
    debug = false,
    sources = {
        f.stylua,
    },
}
