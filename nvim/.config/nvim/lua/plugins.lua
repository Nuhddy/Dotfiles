return require('packer').startup(function(use)

    -- Appearance
    use {
        'shadmansaleh/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'junegunn/goyo.vim'
    use 'lukas-reineke/indent-blankline.nvim'

    -- Utilities
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'preservim/tagbar'
    use 'scrooloose/nerdcommenter'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use 'ntpeters/vim-better-whitespace'
    use 'mattn/emmet-vim'

    -- Git
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'tpope/vim-fugitive'

    -- Syntax
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'tridactyl/vim-tridactyl', ft = 'tridactyl'}
    use {'mboughaba/i3config.vim', ft = 'i3config'}
    use {'baskerville/vim-sxhkdrc', ft = 'sxhkdrc'}
    use {'vim-pandoc/vim-pandoc-syntax', ft = 'pandoc'}

    -- Completion
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-nvim-lua'}
    use {'hrsh7th/cmp-nvim-lsp'}

    -- IPC-like
    use {
        'iamcco/markdown-preview.nvim',
        ft = {'packer', 'markdown', 'pandoc'},
        run = function() vim.fn['mkdp#util#install']() end
    }
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

end)
