local status_ok, _ = pcall(require, 'luasnip')
if not status_ok then
    return
end

require 'user.snippets.config'

-- Snippets from friendly-snippets plugin
require('luasnip.loaders.from_vscode').lazy_load()
-- Custom snippets
require 'user.snippets.custom_source'
