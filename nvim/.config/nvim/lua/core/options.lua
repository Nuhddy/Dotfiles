local function vim_opts(options)
    for scope, table in pairs(options) do
        for setting, value in pairs(table) do
            vim[scope][setting] = value
        end
    end
end

vim.opt.shortmess:append { s = true, I = true, c = true }
vim.opt.iskeyword:append { "-" }

vim_opts {
    opt = {
        -- behavior
        compatible = false,
        encoding = "utf-8",
        fileencoding = "utf-8",
        hidden = true,
        updatetime = 100,
        timeoutlen = 500,
        wrap = false,
        splitbelow = true,
        splitright = true,
        scrolloff = 4,
        sidescrolloff = 4,
        mouse = "a",
        clipboard = "unnamedplus",
        backupcopy = "yes",
        completeopt = { "menu", "menuone", "noselect" },

        -- appearance
        number = true,
        relativenumber = true,
        laststatus = 3,
        showmode = false,
        pumheight = 10,
        cmdheight = 1,
        showtabline = 1,
        termguicolors = true,
        background = "dark",
        guifont = "monospace:h17",

        -- searching
        ignorecase = true,
        smartcase = true,
        incsearch = true,
        hlsearch = false,

        -- indentation
        tabstop = 8,
        softtabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smarttab = true,
        autoindent = true,
    },
    g = {
        mapleader = ",",
        maplocalleader = ",",
    },
}
