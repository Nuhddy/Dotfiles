local lspc = require 'lspconfig'

-- Completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
    )

-- efm
lspc.efm.setup {
    capabilities = capabilities,
    init_options = {documentFormatting = true},
    filetypes = {'lua'},
    settings = {
        rootMarkers = {'.git/'},
        languages = {
            lua = {
                {formatCommand = 'lua-format -i', formatStdin = true}
            }
        }
    }
}

vim.cmd 'au BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)'

-- lua
local sumneko_root_path = '/usr/share/lua-language-server'
local sumneko_binary = '/usr/bin/lua-language-server'

lspc.sumneko_lua.setup {
    capabilities = capabilities,
    cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                globals = {'vim'}
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true)
            },
        }
    }
}

-- python
lspc.pyright.setup {
    capabilities = capabilities,
}
