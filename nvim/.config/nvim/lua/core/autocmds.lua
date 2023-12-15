local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

au({ "VimEnter", "BufEnter" }, {
    desc = "Properly set formatoptions",
    group = aug("formatoptions", { clear = true }),
    pattern = "*",
    callback = function() vim.opt.formatoptions = "njtcql" end,
})

-- Terminal settings
au({ "BufWinEnter", "WinEnter", "TermOpen" }, {
    desc = "Start insert mode when entering terminal buffer",
    group = aug("term", {}),
    pattern = "term://*",
    command = "startinsert",
})

au("BufLeave", {
    desc = "Stop insert mode when leaving terminal buffer",
    group = aug("term", {}),
    pattern = "term://*",
    command = "stopinsert",
})

-- Filetype settings
--[[ au({ "BufNewFile", "BufFilePre", "BufRead" }, {
    desc = "Pandoc markdown filetype settings",
    group = aug("pandocmarkdown", { clear = true }),
    pattern = "*.pdc",
    callback = function()
        vim.bo.filetype = "markdown.pandoc"
        vim.bo.textwidth = 79
    end,
}) ]]

au("FileType", {
    desc = "Pandoc markdown filetype settings",
    group = aug("markdownpandoc", { clear = true }),
    pattern = "markdown.pandoc",
    callback = function() vim.bo.textwidth = 79 end,
})

au("FileType", {
    desc = "Markdown filetype settings",
    group = aug("markdown", { clear = true }),
    pattern = "markdown",
    callback = function() vim.bo.textwidth = 79 end,
})

if vim.g.vscode then return end
au("TextYankPost", {
    desc = "Highlight yanked text",
    group = aug("highlightyank", { clear = true }),
    pattern = "*",
    callback = function() vim.highlight.on_yank { on_visual = false } end,
})
