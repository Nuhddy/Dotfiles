local status_ok, ts = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

ts.setup {
    ensure_installed = 'maintained',
    sync_install = false,
    autopairs = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}
