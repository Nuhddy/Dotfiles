return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            _G.NIXOS == 0 and { 'williamboman/mason.nvim', config = true }
                or nil,
            _G.NIXOS == 0 and 'williamboman/mason-lspconfig.nvim' or nil,
            _G.NIXOS == 0 and 'WhoIsSethDaniel/mason-tool-installer.nvim'
                or nil,
            {
                'j-hui/fidget.nvim',
                opts = {
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup(
                    'lsp-attach',
                    { clear = true }
                ),
                callback = function(event)
                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight
                        )
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            'lsp-highlight',
                            { clear = true }
                        )

                        vim.api.nvim_create_autocmd(
                            { 'CursorHold', 'CursorHoldI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )
                        vim.api.nvim_create_autocmd(
                            { 'CursorMoved', 'CursorMovedI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup(
                                'lsp-detach',
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds {
                                    group = 'lsp-highlight',
                                    buffer = event2.buf,
                                }
                            end,
                        })
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                'force',
                capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- INFO: :help lspconfig-all
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                disable = { 'missing-fields' },
                            },
                            telemetry = { enabled = false },
                        },
                    },
                },
                nixd = {
                    settings = {
                        nixd = {
                            nixpkgs = {
                                expr = 'import (builtins.getFlake "'
                                    .. vim.loop.os_homedir()
                                    .. '/.config/nixos").inputs.nixpkgs { }',
                            },
                            options = {
                                nixos = {
                                    expr = '(builtins.getFlake "'
                                        .. '/.config/nixos").nixosConfigurations."'
                                        .. vim.loop.os_gethostname()
                                        .. '".options',
                                },
                                home_manager = {
                                    expr = '(builtins.getFlake "'
                                        .. '/.config/nixos").homeConfigurations."'
                                        .. vim.loop.os_getenv 'USER'
                                        .. '@'
                                        .. vim.loop.os_gethostname()
                                        .. '".options',
                                },
                            },
                        },
                    },
                },
                -- pyright = {},
                -- ts_ls = {},
            }

            if _G.NIXOS then
                for server, _ in pairs(servers) do
                    require('lspconfig')[server].setup {
                        capabilities = capabilities,
                    }
                end
            else
                require('mason').setup()
                local ensure_installed = vim.tbl_keys(servers or {})
                local formatters = {}
                for _, ft in pairs(_G.FORMATTERS) do
                    for i = 1, #ft do
                        local formatter = ft[i]
                        table.insert(formatters, formatter)
                    end
                end
                vim.list_extend(ensure_installed, formatters)
                require('mason-tool-installer').setup {
                    ensure_installed = ensure_installed,
                }
                require('mason-lspconfig').setup {
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities = vim.tbl_deep_extend(
                                'force',
                                {},
                                capabilities,
                                server.capabilities or {}
                            )
                            require('lspconfig')[server_name].setup(server)
                        end,
                    },
                }
            end
        end,
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the 'vim.uv' word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        'jmbuhr/otter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
}
