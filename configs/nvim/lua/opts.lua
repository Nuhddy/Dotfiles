require('util').set_opts {
    opt = {
        updatetime = 250,
        timeoutlen = 500,
        wrap = false,
        splitbelow = true,
        splitright = true,
        scrolloff = 4,
        sidescrolloff = 4,
        mouse = 'a',
        backupcopy = 'yes',
        undofile = true,
        completeopt = { 'menu', 'menuone', 'noselect' },

        number = true,
        relativenumber = true,
        laststatus = 3,
        showmode = false,
        cursorline = true,
        pumheight = 10,
        cmdheight = 1,
        showtabline = 1,
        breakindent = true,
        termguicolors = true,
        guifont = 'monospace:h17',
        conceallevel = 2,

        ignorecase = true,
        smartcase = true,
        incsearch = true,
        hlsearch = false,
        inccommand = 'split',

        shiftwidth = 4, -- spaces inserted by tabs and shift operations
        tabstop = 8,
        softtabstop = -1,
        expandtab = true,
        smarttab = true,
        autoindent = true,
    },
    g = {
        mapleader = ',',
        maplocalleader = ',',
    },
}

-- Appended options
vim.opt.shortmess:append { s = true, I = true, c = true }
vim.opt.iskeyword:append { '-' }

-- Scheduled to decrease startup time
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- Set formatoptions per buffer
au({ 'VimEnter', 'BufEnter' }, {
    desc = 'Properly set formatoptions',
    group = aug('formatoptions', { clear = true }),
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = 'njtcql'
    end,
})

-- Highlight on yank
au('TextYankPost', {
    desc = 'Highlight yanked text',
    group = aug('highlightyank', { clear = true }),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Terminal bindings
au({ 'BufWinEnter', 'WinEnter', 'TermOpen' }, {
    desc = 'Start insert mode when entering terminal buffer',
    group = aug('term', {}),
    pattern = 'term://*',
    command = 'startinsert',
})
au('BufLeave', {
    desc = 'Stop insert mode when leaving terminal buffer',
    group = aug('term', {}),
    pattern = 'term://*',
    command = 'stopinsert',
})
