-- Keymap helper
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('i', '<leader><leader>', '<ESC>/<++><CR>"_c4l') -- go to next temporary
                                                    -- mark (look into regular
                                                    -- vim marks)
map('t', '<ESC>', '<C-\\><C-n>') -- escape terminal

-- Spell check
map('n', '<leader>od', ':setlocal spell! spelllang=da<CR>')
map('n', '<leader>oe', ':setlocal spell! spelllang=en<CR>')

-- Pandoc compilation
map('n', '<leader>epdf', ':!pandoc -f markdown -t pdf %<CR><CR>')
map('n', '<leader>eepub', ':!pandoc -f markdown -t epub %<CR><CR>')

-- Latex macros
map('i', '<leader>infer1', '\\infer[<++>]<CR><TAB>{<++>}<CR>{<++>}<CR><BACKSPACE><ESC>3k0i')
map('i', '<leader>infer2', '\\infer[<++>]<CR><TAB>{<++>}<CR>{<++> &<CR><++>}<CR><BACKSPACE><ESC>4k0i')
map('i', '<leader>infer3', '\\infer[<++>]<CR><TAB>{<++>}<CR>{<++> &<CR><++> &<CR><++>}<CR><BACKSPACE><ESC>5k0i')

-- Completion
--[[
   [ map('i', '<CR>', '(pumvisible() ? "\\<C-y>\\<CR>" : "\\<CR>")', { expr = true })
   [ map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
   [ map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })
   ]]

-- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

-- Git
map('n', '<leader>gs', ':Gitsigns toggle_signs<CR>')
map('n', '<leader>gg', ':Git<CR>')
map('n', '<leader>gc', ':Gcommit<space>%<CR>')
map('n', '<leader>gw', ':Gwrite<CR>')

-- Other plugins
map('n', '<leader>go', ':Goyo<CR>')
map('n', '<leader>t', ':TagbarToggle<CR>')
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', '<C-e>', '<Plug>(ale_next_wrap)') -- go to next linter error
map('n', '<leader>mp', '<Plug>MarkdownPreviewToggle')
