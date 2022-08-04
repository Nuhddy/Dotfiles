local status_ok, ls = pcall(require, 'luasnip')
if not status_ok then
    return
end

ls.config.set_config {
    history = true, -- allows jumping back into most recent snippet
    updateevents = 'TextChanged,TextChangedI',
}

local function kset(mode, lhs, rhs, opts)
    local default_opts = { silent = true }
    require('user.lib.utils').keymap_set(mode, lhs, rhs, opts, default_opts)
end

kset({ 'i', 's' }, '<C-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)
kset({ 'i', 's' }, '<C-j>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)
kset('i', '<C-l>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- Snippets from friendly-snippets plugin
require('luasnip.loaders.from_vscode').lazy_load()
-- Custom snippets
require 'user.snippets.custom_source'
