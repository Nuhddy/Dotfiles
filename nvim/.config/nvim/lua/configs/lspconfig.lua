local lspconfig = require "lspconfig"
local set_mappings = require("core.utils").set_mappings

-- On attach
local function on_attach(client, bufnr)
    local maps = { n = {} }
    local default_options = { silent = true }

    maps.n["K"] =
        { function() vim.lsp.buf.hover() end, desc = "Show hover popup" }
    maps.n["gd"] =
        { function() vim.lsp.buf.definition() end, desc = "Go to definition" }
    maps.n["gr"] =
        { function() vim.lsp.buf.references() end, desc = "Go to references" }
    maps.n["gi"] = {
        function() vim.lsp.buf.implementation() end,
        desc = "Go to implementation",
    }
    maps.n["gD"] =
        { function() vim.lsp.buf.declaration() end, desc = "Go to declaration" }

    maps.n["[d"] = {
        function() vim.diagnostic.goto_prev() end,
        desc = "Go to previous diagnostic",
    }
    maps.n["]d"] = {
        function() vim.diagnostic.goto_next() end,
        desc = "Go to next diagnostic",
    }
    maps.n["gl"] = {
        function() vim.diagnostic.open_float() end,
        desc = "Show diagnostics in floating window",
    }
    maps.n["<leader>q"] =
        { function() vim.diagnostic.setloclist() end, desc = "" }

    set_mappings(maps, default_options)

    -- navic plugin
    local navic_ok, navic = pcall(require, "nvim-navic")
    if navic_ok then
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Server settings
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enabled = false,
            },
        },
    },
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.bashls.setup {}
