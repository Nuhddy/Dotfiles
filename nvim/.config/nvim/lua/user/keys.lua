-- Keymap helper
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Navigate splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('i', '<leader><leader>', '<ESC>/<++><CR>"_c4l') -- go to next temporary
-- mark (look into regular
-- vim marks)
map('t', '<ESC>', '<C-\\><C-n>') -- escape terminal

-- Resize splits
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Navigate buffers
map('n', '<A-h>', ':bprevious<CR>')
map('n', '<A-l>', ':bnext<CR>')

-- Move text
map('n', '<A-j>', ':move .+1<CR>==gi<ESC>')
map('n', '<A-k>', ':move .-2<CR>==gi<ESC>')
map('v', '<A-j>', ':move .+1<CR>==')
map('v', '<A-k>', ':move .-2<CR>==')
map('x', '<A-j>', ":move '>+1<CR>gv-gv")
map('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Spell check
map('n', '<leader>o', ':setlocal spell! spelllang=da,en<CR>')

-- Pandoc compilation
map('n', '<leader>xpdf', ':!pandoc -f markdown -t pdf %<CR><CR>')
map('n', '<leader>xepub', ':!pandoc -f markdown -t epub %<CR><CR>')

-- Git
map('n', '<leader>gs', ':Gitsigns toggle_signs<CR>')
map('n', '<leader>gg', ':Git<CR>')
map('n', '<leader>gc', ':Gcommit<space>%<CR>')
map('n', '<leader>gw', ':Gwrite<CR>')

-- Other plugins
map('n', '<leader>go', ':Goyo<CR>')
map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>mp', ':MarkdownPreviewToggle<CR>')
map('n', '<leader>t', ':Telescope find_files<CR>')
map('n', '<leader>f', ':lua vim.lsp.buf.formatting_sync()<CR>')
