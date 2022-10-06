local notify_status_ok, notify = pcall(require, 'notify')
if not notify_status_ok then
    return
end

vim.notify = require 'notify'

notify.setup {
    fps = 60,
    level = 'info',
    stages = 'fade',
    timeout = 2000,
}

require('telescope').load_extension('notify')

-- Display LSP progress as notification
local lsp_status_ok, _ = pcall(require, 'lspconfig')
if not lsp_status_ok then
    return
end

require 'user.notify.lsp-progress'
