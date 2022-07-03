local kset = vim.keymap.set

-- Leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Navigate splits
kset('n', '<C-h>', '<C-w>h')
kset('n', '<C-j>', '<C-w>j')
kset('n', '<C-k>', '<C-w>k')
kset('n', '<C-l>', '<C-w>l')
-- go to next temporary mark (look into regular vim marks)
-- kset('i', '<leader><leader>', '<ESC>/<++><CR>"_c4l')
kset('t', '<ESC>', '<C-\\><C-n>') -- escape terminal

-- Resize splits
kset('n', '<C-Up>', ':resize -2<CR>')
kset('n', '<C-Down>', ':resize +2<CR>')
kset('n', '<C-Left>', ':vertical resize -2<CR>')
kset('n', '<C-Right>', ':vertical resize +2<CR>')

-- Navigate buffers
kset('n', '<A-h>', ':bprevious<CR>')
kset('n', '<A-l>', ':bnext<CR>')

-- Move text (some of these don't work)
-- kset('n', '<A-j>', ':move .+1<CR>==gi<ESC>')
-- kset('n', '<A-k>', ':move .-2<CR>==gi<ESC>')
kset('v', '<A-j>', ':move .+1<CR>==')
kset('v', '<A-k>', ':move .-2<CR>==')
-- kset('x', '<A-j>', ":move '>+1<CR>gv-gv")
-- kset('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Stay in indent mode
kset('v', '<', '<gv')
kset('v', '>', '>gv')

-- Spell check
kset('n', '<leader>o', ':setlocal spell! spelllang=da,en<CR>')

-- Pandoc compilation
kset('n', '<leader>xpdf', ':!pandoc -f markdown -t pdf %<CR><CR>')
kset('n', '<leader>xepub', ':!pandoc -f markdown -t epub %<CR><CR>')

-- Git
kset('n', '<leader>gs', ':Gitsigns toggle_signs<CR>')
kset('n', '<leader>gg', ':Git<CR>')
kset('n', '<leader>gc', ':Gcommit<space>%<CR>')
kset('n', '<leader>gw', ':Gwrite<CR>')

-- Other plugins
kset('n', '<leader>go', ':Goyo<CR>')
kset('n', '<leader>e', ':NvimTreeToggle<CR>')
kset('n', '<leader>mp', ':MarkdownPreviewToggle<CR>')
kset('n', '<leader>t', ':Telescope find_files<CR>')
kset('n', '<leader>f', ':lua vim.lsp.buf.formatting_sync()<CR>')
