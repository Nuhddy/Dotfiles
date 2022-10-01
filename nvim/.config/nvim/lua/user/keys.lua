-- Sets keymap with default :map-arguments (custom opts override defaults)
local function kset(mode, lhs, rhs, opts)
    local default_opts = { silent = true }
    require('user.lib.utils').keymap_set(mode, lhs, rhs, opts, default_opts)
end

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
kset('n', '<C-Up>', '<cmd>resize -2<CR>')
kset('n', '<C-Down>', '<cmd>resize +2<CR>')
kset('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
kset('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Navigate buffers
kset('n', '<A-h>', '<cmd>bprevious<CR>')
kset('n', '<A-l>', '<cmd>bnext<CR>')

-- Move text (some of these don't work)
-- kset('n', '<A-j>', '<cmd>move .+1<CR>==gi<ESC>')
-- kset('n', '<A-k>', '<cmd>move .-2<CR>==gi<ESC>')
kset('v', '<A-j>', '<cmd>move .+1<CR>==')
kset('v', '<A-k>', '<cmd>move .-2<CR>==')
-- kset('x', '<A-j>', "<cmd>move '>+1<CR>gv-gv")
-- kset('x', '<A-k>', "<cmd>move '<-2<CR>gv-gv")

-- Stay in indent mode
kset('v', '<', '<gv')
kset('v', '>', '>gv')

-- Spell check
kset('n', '<leader>o', '<cmd>setlocal spell! spelllang=da,en<CR>')

-- Pandoc compilation
kset('n', '<leader>xpdf', '<cmd>!pandoc -f markdown -t pdf %<CR><CR>')
kset('n', '<leader>xepub', '<cmd>!pandoc -f markdown -t epub %<CR><CR>')

-- Git
kset('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<CR>')
kset('n', '<leader>gg', '<cmd>Git<CR>')
kset('n', '<leader>gc', '<cmd>Gcommit<space>%<CR>')
kset('n', '<leader>gw', '<cmd>Gwrite<CR>')

-- Other plugins
kset('n', '<leader>go', '<cmd>Goyo<CR>')
kset('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
kset('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>')
kset(
    'n',
    '<leader>t',
    '<cmd>lua require("user.lib.utils").telescope_project_files()<CR>'
)
kset('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>')
