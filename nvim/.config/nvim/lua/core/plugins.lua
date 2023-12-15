-- Auto-bootstrap packer
local install_path = vim.fn.stdpath "data"
    .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end

-- Reload neovim after writing to file
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("pluginfilereload", {}),
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
})

-- Prevent error on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Display packer in floating window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
    config = {
        compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    },
}

return packer.startup {
    function(use)
        use "wbthomason/packer.nvim"
        use "nvim-lua/popup.nvim"
        use "lewis6991/impatient.nvim"
        use {
            "catppuccin/nvim",
            as = "catppuccin",
            config = function() require "configs.catppuccin" end,
        }
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "muniftanjim/nui.nvim",
            },
            config = function() require "configs.neo-tree" end,
        }
        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function() require "configs.autopairs" end,
        }
        use {
            "numtostr/comment.nvim",
            config = function() require "configs.comment" end,
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function() require "configs.indent-blankline" end,
        }
        use {
            "windwp/nvim-ts-autotag",
            after = "nvim-treesitter",
            config = function() require("nvim-ts-autotag").setup() end,
        }
        use {
            "joosepalviste/nvim-ts-context-commentstring",
            after = "nvim-treesitter",
        }
        use {
            "nvchad/nvim-colorizer.lua",
            config = function() require("colorizer").setup {} end,
        }
        use "tpope/vim-surround"
        use {
            "mcauley-penney/tidy.nvim",
            config = function() require("tidy").setup() end,
        }
        use { "mattn/emmet-vim", ft = { "html", "css" } }
        use {
            "fgheng/winbar.nvim",
            config = function() require "configs.winbar" end,
        }
        use { "smiteshp/nvim-navic", requires = "neovim/nvim-lspconfig" }
        --[[ use {
            "rebelot/heirline.nvim",
            config = function() require "configs.heirline" end,
        } ]]
        use {
            "nvim-lualine/lualine.nvim",
            config = function() require "configs.lualine" end,
        }
        use {
            "iamcco/markdown-preview.nvim",
            ft = { "packer", "markdown", "markdown.pandoc" },
            run = function() vim.fn["mkdp#util#install"]() end,
            config = function()
                vim.g.mkdp_filetypes = { "markdown", "markdown.pandoc" }
            end,
        }
        use {
            "glacambre/firenvim",
            run = function() vim.fn["firenvim#install"](0) end,
            config = function() require "configs.firenvim" end,
        }
        use {
            "nvim-telescope/telescope.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function() require "configs.telescope" end,
        }

        -- Syntax highlighting
        use { "tridactyl/vim-tridactyl", ft = "tridactyl" }
        use {
            "vim-pandoc/vim-pandoc-syntax",
            ft = "markdown.pandoc",
            config = function() vim.g["pandoc#syntax#conceal#use"] = 0 end,
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                require("nvim-treesitter.install").update { with_sync = true }
            end,
            config = function() require "configs.treesitter" end,
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            config = function() require "configs.lspconfig" end,
        }
        use {
            "jose-elias-alvarez/null-ls.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function() require "configs.null-ls" end,
        }
        use {
            "williamboman/mason.nvim",
            config = function() require "configs.mason" end,
        }
        use {
            "williamboman/mason-lspconfig.nvim",
            after = "nvim-lspconfig",
            config = function() require "configs.mason-lspconfig" end,
        }
        use {
            "jayp0521/mason-null-ls.nvim",
            after = "null-ls.nvim",
            config = function() require "configs.mason-null-ls" end,
        }

        -- Snippets
        use "rafamadriz/friendly-snippets"
        use {
            "l3mon4d3/luasnip",
            wants = "friendly-snippets",
            config = function() require "config.luasnip" end,
        }

        -- Completion
        use {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            config = function() require "configs.cmp" end,
        }
        use {
            "hrsh7th/cmp-path",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source { name = "path" }
            end,
        }
        use {
            "hrsh7th/cmp-buffer",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source {
                    name = "buffer",
                    keyword_length = 7,
                }
            end,
        }
        --[[ use {
            "hrsh7th/cmp-cmdline",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source { name = "cmdline" }
            end,
        } ]]
        use {
            "hrsh7th/cmp-nvim-lua",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source { name = "nvim_lua" }
            end,
        }
        use {
            "hrsh7th/cmp-nvim-lsp",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source { name = "nvim_lsp" }
            end,
        }
        use {
            "saadparwaiz1/cmp_luasnip",
            after = "nvim-cmp",
            config = function()
                require("core.utils").cmp_add_source { name = "luasnip" }
            end,
        }
    end,
}
