return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require 'which-key'
        local telescope = require 'telescope.builtin'

        wk.add {
            { '<c-h>', '<c-w>h', desc = 'Focus left' },
            { '<c-j>', '<c-w>j', desc = 'Focus down' },
            { '<c-k>', '<c-w>k', desc = 'Focus up' },
            { '<c-l>', '<c-w>l', desc = 'Focus right' },

            { '<c-up>', '<cmd>resize +2<cr>', desc = 'Resize taller' },
            { '<c-down>', '<cmd>resize -2<cr>', desc = 'Resize shorter' },
            {
                '<c-left>',
                '<cmd>vertical resize -2<cr>',
                desc = 'Resize narrower',
            },
            {
                '<c-right>',
                '<cmd>vertical resize +2<cr>',
                desc = 'Resize wider',
            },

            {
                '<esc><esc>',
                '<c-\\><c-n>',
                mode = 't',
                desc = 'Exit terminal mode',
            },
            {
                '<',
                '<gv',
                mode = 'v',
                desc = 'Stay in visual mode after shift operation',
            },
            {
                '>',
                '>gv',
                mode = 'v',
                desc = 'Stay in visual mode after shift operation',
            },
        }

        wk.add {
            {
                '<leader>q',
                vim.diagnostic.setloclist,
                desc = 'Open diagnostic quickfix list',
            },
        }

        wk.add {
            { '<leader>g', group = 'Goto (LSP)' },
            {
                '<leader>gd',
                telescope.lsp_definitions,
                desc = 'Goto definition',
            },
            {
                '<leader>gr',
                telescope.lsp_references,
                desc = 'Goto references',
            },
            {
                '<leader>gt',
                telescope.lsp_type_definitions,
                desc = 'Goto type definition',
            },
            {
                '<leader>gD',
                vim.lsp.buf.declaration,
                desc = 'Goto declaration',
            },
            {
                '<leader>gi',
                telescope.lsp_implementations,
                desc = 'Goto implementations',
            },
        }

        wk.add {
            { '<leader>rn', vim.lsp.buf.rename, desc = 'Rename variable' },
            {
                '<leader>f',
                function()
                    require('conform').format {
                        async = true,
                        lsp_fallback = true,
                    }
                end,
                desc = 'Format buffer',
            },
            {
                '<leader>e',
                '<cmd>Neotree toggle<cr>',
                desc = 'Toggle file explorer',
            },
            { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
        }

        wk.add {
            { '<leader>o', group = 'Spell check' },
            {
                '<leader>oo',
                '<cmd>setlocal spell! spelllang=en,da<cr>',
                desc = 'Toggle spell check',
            },
            {
                '<leader>oe',
                '<cmd>setlocal spelllang=en<cr>',
                desc = 'Enable spell check - English(US)',
            },
            {
                '<leader>od',
                '<cmd>setlocal spelllang=da<cr>',
                desc = 'Enable spell check - Danish',
            },
        }

        wk.add {
            { '<leader>s', group = 'Search' },
            { '<leader>sf', telescope.find_files, desc = 'Search files' },
            { '<leader>sg', telescope.live_grep, desc = 'Search by grep' },
            { '<leader>sk', telescope.keymaps, desc = 'Search keymaps' },
        }
    end,
}
