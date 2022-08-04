local status_ok, nightfox = pcall(require, 'nightfox')
if not status_ok then
    return
end

-- Custom highlight groups
vim.api.nvim_set_hl(0, 'DiagnosticLineNrError', {})
vim.api.nvim_set_hl(0, 'DiagnosticLineNrWarn', {})
vim.api.nvim_set_hl(0, 'DiagnosticLineNrHint', {})
vim.api.nvim_set_hl(0, 'DiagnosticLineNrInfo', {})

-- Colorscheme setup
nightfox.setup {
    groups = {
        all = {
            IndentBlanklineIndent1 = { fg = 'bg2', style = 'nocombine' },

            DiagnosticLineNrError = { fg = 'diag.error', style = 'bold' },
            DiagnosticLineNrWarn = { fg = 'diag.warn', style = 'bold' },
            DiagnosticLineNrHint = { fg = 'diag.hint', style = 'bold' },
            DiagnosticLineNrInfo = { fg = 'diag.info', style = 'bold' },
        },
    },
}

vim.cmd 'colorscheme nordfox'
