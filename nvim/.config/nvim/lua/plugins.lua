return require('packer').startup(function()

    -- Appearance
    use {
        'glepnir/galaxyline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'junegunn/goyo.vim'
    --[[ doesn't work with vim.o.cursorline
       [ use 'lukas-reineke/indent-blankline.nvim'
       ]]

    -- Utilities
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'preservim/tagbar'
    use 'dense-analysis/ale'
    use 'scrooloose/nerdcommenter'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use 'ntpeters/vim-better-whitespace'
    use 'mattn/emmet-vim'

    -- Git
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'tpope/vim-fugitive'

    -- Syntax
    use { 'tridactyl/vim-tridactyl', ft = 'tridactyl' }
    use { 'mboughaba/i3config.vim', ft = 'i3config' }
    use { 'baskerville/vim-sxhkdrc', ft = 'sxhkdrc' }
    use { 'cespare/vim-toml', ft = 'toml' }
    use { 'vim-pandoc/vim-pandoc-syntax', ft = 'pandoc' }
    use { 'euclidianace/betterlua.vim', ft = 'lua' }

    -- Completion
    use { 'ncm2/ncm2', requires = 'roxma/nvim-yarp' }
    use 'ncm2/ncm2-bufword'
    use 'ncm2/ncm2-path'
    use { 'ncm2/ncm2-jedi', ft = 'python' }
    use {
        'observeroftime/ncm2-jc2', ft = { 'java', 'jsp' },
        requires = {
            'artur-shaik/vim-javacomplete2',
            ft = { 'java', 'jsp' }
        }
    }

    -- IPC-like
    use {
        'iamcco/markdown-preview.nvim',
        ft = { 'packer', 'markdown', 'pandoc' },
        run = function() vim.fn['mkdp#util#install']() end
    }
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

end)
