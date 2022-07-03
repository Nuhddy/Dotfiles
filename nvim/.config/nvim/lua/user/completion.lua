local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
    return
end

-- local fn = vim.fn

-- what does this do??
-- local check_backspace = function()
--     local col = fn.col '.' - 1
--     return col == 0 or fn.getline('.'):sub(col, col):match '%s'
-- end

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

if cmp ~= nil then
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Insert
            },
            ['<C-n>'] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Insert
            },
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['C-y'] = cmp.mapping(
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                },
                { 'i', 'c' }
            ),
            ['<C-Space>'] = cmp.mapping.complete(),

            -- Super-tab functionality
            -- ['<Tab>'] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_next_item()
            --     elseif luasnip.expandable() then
            --         luasnip.expand()
            --     elseif luasnip.expand_or_jumpable() then
            --         luasnip.expand_or_jump()
            --     elseif check_backspace() then
            --         fallback()
            --     else
            --         fallback()
            --     end
            -- end, {
            --     'i',
            --     's',
            -- }),
            -- ['<S-Tab>'] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_prev_item()
            --     elseif luasnip.jumpable(-1) then
            --         luasnip.jump(-1)
            --     else
            --         fallback()
            --     end
            -- end, {
            --     'i',
            --     's',
            -- }),
        },
        formatting = {
            -- look into lspkind plugin
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[NVIM]',
                    cmdline = '[VIM]',
                    luasnip = '[SNIP]',
                    buffer = '[BUF]',
                    path = '[PATH]',
                })[entry.source.name]
                return vim_item
            end,
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            { name = 'cmdline' },
            { name = 'path' },
            { name = 'buffer', keyword_length = 5 },
        },
        window = {
            documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = true,
            native_menu = false,
        },
    }
end
