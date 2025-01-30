return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- if vim.bo[bufnr].filetype == 'python' then
            --     return false
            -- end
            local disable_filetypes = {}
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        -- INFO: :help conform-formatters
        formatters_by_ft = _G.FORMATTERS,
    },
}
