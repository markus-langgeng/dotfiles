return { -- LSP Configuration & Plugins
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim",          build = ":MasonUpdate" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "folke/neodev.nvim" },
            {
                "j-hui/fidget.nvim",
                version = "legacy",
                tag = "legacy",
                config = function()
                    -- Turn on lsp status information
                    require("fidget").setup({
                        window = {
                            blend = 0,
                        }
                    })
                end
            },
        },

        config = function()
            -- Change border of documentation hover window
            local lsp_h = vim.lsp.handlers
            lsp_h["textDocument/hover"] = vim.lsp.with(lsp_h.hover, {
                border = "rounded",
            })
            lsp_h["textDocument/signatureHelp"] = vim.lsp.with(lsp_h.signature_help, {
                border = "rounded",
            })
            vim.diagnostic.config({ float = { border = "rounded" } })
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            -- LSP settings.
            --  This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(client, bufnr)
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                local lsp_b = vim.lsp.buf
                local builtin = require("telescope.builtin")

                nmap("<leader>rn", lsp_b.rename, "[R]e[n]ame")
                nmap("<leader>ca", lsp_b.code_action, "[C]ode [A]ction")

                nmap("gd", lsp_b.definition, "[G]oto [D]efinition")
                nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
                nmap("gI", lsp_b.implementation, "[G]oto [I]mplementation")
                nmap("<leader>D", lsp_b.type_definition, "Type [D]efinition")
                nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- See `:help K` for why this keymap
                nmap("K", lsp_b.hover, "Hover Documentation")
                nmap("<C-k>", lsp_b.signature_help, "Signature Documentation")

                -- Lesser used LSP functionality
                nmap("gD", lsp_b.declaration, "[G]oto [D]eclaration")
                nmap("<leader>wa", lsp_b.add_workspace_folder, "[W]orkspace [A]dd Folder")
                nmap("<leader>wr", lsp_b.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                nmap("<leader>wl", function()
                    print(vim.inspect(lsp_b.list_workspace_folders()))
                end, "[W]orkspace [L]ist Folders")

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    lsp_b.format()
                end, { desc = "Format current buffer with LSP" })
            end

            -- Setup mason so it can manage external tooling
            require("mason").setup({})
            require("neodev").setup()


            -- Automatically install servers on the list
            local servers = {
                clangd = {},
                gopls = {},
                -- pyright = {},
                -- tsserver = {},
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                texlab = {},
                -- jsonls = {
                --     single_file_support = true
                -- },
                -- psalm = {},
                -- why is it so hard to set up? this doesn't have any effect!
                -- phpactor = {
                --     init_options = {
                --         ["language_server_phpstan.enabled"] = false,
                --         ["language_server_psalm.enabled"] = true,
                --         ["language_server_php_cs_fixer.enabled"] = true,
                --         ["language_server_completion.trim_leading_dollar"] = true,
                --         ["language_server_php_cs_fixer.bin"] = "~/.local/share/nvim/mason/packages/php-cs-fixer",
                --         ["language_server.diagnostics_on_update"] = false,
                --     }
                -- },
            }


            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    if server_name == "emmet_ls" then
                        require("lspconfig")["emmet_ls"].setup {
                            capabilities = capabilities,
                            on_attach    = function(client)
                                client.server_capabilities.completionProvider.triggerCharacters = { "." }
                            end,
                            settings     = servers[server_name],
                        }
                    elseif server_name == "clangd" then
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities,
                            on_attach    = on_attach,
                            settings     = servers[server_name],
                            autostart    = false
                        }
                    else
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities,
                            on_attach    = on_attach,
                            settings     = servers[server_name],
                        }
                    end
                end
            }
        end,
    }
}
