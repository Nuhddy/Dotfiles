return require('packer').startup(function()

    -- Window utils
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'preservim/tagbar'
    use { 'scrooloose/nerdtree', cmd = 'NERDTreeToggle' }

    -- Editing utils
    use 'dense-analysis/ale'
    use 'scrooloose/nerdcommenter'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use 'ntpeters/vim-better-whitespace'
    use 'norcalli/nvim-colorizer.lua'
    use 'yggdroot/indentline'
    use 'junegunn/goyo.vim'
    use 'mattn/emmet-vim'
    use {
        'iamcco/markdown-preview.nvim',
        ft = { 'packer', 'markdown', 'markdown.pandoc' },
        run = function() vim.fn['mkdp#util#install']() end
    }

    -- Git
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    -- Syntax
    use { 'tridactyl/vim-tridactyl', ft = 'tridactyl' }
    use { 'mboughaba/i3config.vim', ft = 'i3config' }
    use { 'baskerville/vim-sxhkdrc', ft = 'sxhkdrc' }
    use { 'cespare/vim-toml', ft = 'toml' }
    use { 'vim-pandoc/vim-pandoc-syntax', ft = 'pandoc' }

    -- Completion
    use { 'ncm2/ncm2', requires = 'roxma/nvim-yarp' }
    use 'ncm2/ncm2-bufword'
    use 'ncm2/ncm2-path'
    use { 'ncm2/ncm2-jedi', ft = 'python' }
    use {
        'observeroftime/ncm2-jc2', ft = { 'java', 'jsp' },
        requires = { 'artur-shaik/vim-javacomplete2', ft = { 'java', 'jsp' }}
    }

    -- Firenvim
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

end)
