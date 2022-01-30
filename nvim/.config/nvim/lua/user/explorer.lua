local status_ok, nvimtree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

nvimtree.setup {
    auto_close = true,
    ignore_ft_on_setup = { 'startify' },
}
