local status_ok, nvimtree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

nvimtree.setup {
    ignore_ft_on_setup = { 'startify' },
}

local au = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup('nvimtree_auto_close', {})

au('BufEnter', {
    group = 'nvimtree_auto_close',
    pattern = '*',
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
