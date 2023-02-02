local cmp = require "cmp"
-- local luasnip = require("luasnip")

if cmp == nil then return end

-- Completion source icons
local kind_icons = {
    Text = '',
    Method = 'm',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

cmp.setup {
    --[[snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },]]
    mapping = {
        ["<c-p>"] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert,
        },
        ["<c-n>"] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert,
        },
        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
        ["<c-space>"] = cmp.mapping.complete(),
    },
    formatting = {
        -- look into lspkind plugin
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM]",
                cmdline = "[VIM]",
                luasnip = "[SNIP]",
                buffer = "[BUF]",
                path = "[PATH]",
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}
