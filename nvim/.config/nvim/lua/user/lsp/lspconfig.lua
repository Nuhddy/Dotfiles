local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
    return
end

local function kset(mode, lhs, rhs, opts)
    local default_opts = { silent = true, buffer = 0 }
    require('user.lib.utils').keymap_set(mode, lhs, rhs, opts, default_opts)
end

local function navic_on_attach(client, bufnr)
    local navic_status_ok, navic = pcall(require, 'nvim-navic')
    if not navic_status_ok then
        return
    end

    navic.attach(client, bufnr)
end

local function on_attach(client, bufnr)
    kset('n', 'K', vim.lsp.buf.hover)
    kset('n', 'gd', vim.lsp.buf.definition)
    kset('n', 'gr', vim.lsp.buf.references) -- show refs in telescope instead?
    kset('n', 'gi', vim.lsp.buf.implementation)
    kset('n', 'gD', vim.lsp.buf.declaration)

    kset('n', '[d', vim.diagnostic.goto_prev)
    kset('n', ']d', vim.diagnostic.goto_next)
    kset('n', 'gl', vim.diagnostic.open_float)
    kset('n', '<leader>q', vim.diagnostic.setloclist)

    if client.server_capabilities.documentSymbolProvider then
        navic_on_attach(client, bufnr)
    end
end

-- Diagnostics
local signs = {
    {
        name = 'DiagnosticSignError',
        text = '',
        num = 'DiagnosticLineNrError',
    },
    {
        name = 'DiagnosticSignWarn',
        text = '',
        num = 'DiagnosticLineNrWarn',
    },
    {
        name = 'DiagnosticSignHint',
        text = '',
        num = 'DiagnosticLineNrHint',
    },
    {
        name = 'DiagnosticSignInfo',
        text = '',
        num = 'DiagnosticLineNrInfo',
    },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = '', text = '', numhl = sign.num })
end

vim.diagnostic.config {
    virtual_text = false,
    signs = {
        active = signs,
    },
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'none',
        source = 'always',
        header = '',
        prefix = '',
    },
}

-- Add completion capabilities
local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- Server settings
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {},
    },
}
