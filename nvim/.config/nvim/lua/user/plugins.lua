local fn = vim.fn
local cmd = vim.cmd

-- Auto-bootstrap packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
end

-- Reload neovim after writing to plugins.lua
cmd [[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup END
]]

-- Prevent error on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Use packer in popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

-- Package management
return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/popup.nvim'
        use 'lewis6991/impatient.nvim'

        -- Appearance
        use '~/Projects/flavours.nvim'
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        }
        use {
            'akinsho/bufferline.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        }
        use 'norcalli/nvim-colorizer.lua'
        use 'junegunn/goyo.vim'
        use 'lukas-reineke/indent-blankline.nvim'

        -- Utilities
        use {
            'kyazdani42/nvim-tree.lua',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        }
        use 'preservim/tagbar'
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
        }
        use 'ahmedkhalf/project.nvim'
        use {
            'goolord/alpha-nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
        }
        use 'numtostr/comment.nvim'
        use 'tpope/vim-surround'
        use 'windwp/nvim-autopairs'
        use 'ntpeters/vim-better-whitespace'
        use 'mattn/emmet-vim'

        -- Git
        use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
        use 'tpope/vim-fugitive'

        -- Syntax
        use { 'tridactyl/vim-tridactyl', ft = 'tridactyl' }
        use { 'mboughaba/i3config.vim', ft = 'i3config' }
        use { 'baskerville/vim-sxhkdrc', ft = 'sxhkdrc' }
        use { 'vim-pandoc/vim-pandoc-syntax', ft = 'pandoc' }

        -- Treesitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use 'nvim-treesitter/playground'
        use 'joosepalviste/nvim-ts-context-commentstring'

        -- Completion
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-cmdline' -- vim commands
        use 'hrsh7th/cmp-nvim-lua' -- nvim lua API
        use 'hrsh7th/cmp-nvim-lsp'
        use 'saadparwaiz1/cmp_luasnip'

        --Snippets
        use 'l3mon4d3/luasnip'
        use 'rafamadriz/friendly-snippets'

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'williamboman/nvim-lsp-installer'
        use {
            'jose-elias-alvarez/null-ls.nvim',
            requires = 'nvim-lua/plenary.nvim',
        }

        -- IPC-like
        use {
            'iamcco/markdown-preview.nvim',
            ft = { 'packer', 'markdown', 'pandoc' },
            run = function()
                fn['mkdp#util#install']()
            end,
        }
        use {
            'glacambre/firenvim',
            run = function()
                fn['firenvim#install'](0)
            end,
        }

        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end,
}, {
    config = {
        compile_path = fn.stdpath 'config' .. '/lua/packer_compiled.lua',
    },
})
