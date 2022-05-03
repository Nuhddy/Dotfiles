local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

aug('markdown', {})
au({'BufNewFile', 'BufRead'}, {
    group = 'markdown',
    pattern = '*.md',
    command = 'lua vim.bo.textwidth = 79',
})

aug('pandoc', {})
au({'BufNewFile', 'BufFilePre', 'BufRead'}, {
    group = 'pandoc',
    pattern = '*.pdc',
    command = 'lua vim.bo.filetype = "pandoc" vim.bo.textwidth = 79',
})

aug('term', {})
au({'BufWinEnter', 'WinEnter', 'TermOpen'}, {
    group = 'term',
    pattern = 'term://*',
    command = 'startinsert',
})
au('BufLeave', {
    group = 'term',
    pattern = 'term://*',
    command = 'stopinsert',
})
