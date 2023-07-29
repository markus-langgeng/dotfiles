local M
M = { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
}

M.dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim",          build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "folke/neodev.nvim" },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        config = function()
            -- Turn on lsp status information
            require("fidget").setup({ window = { blend = 0, } })
        end
    },
}

M.config = function()
    local lspbuf = vim.lsp.buf
    local builtin = require("telescope.builtin")
    local usrcommand = vim.api.nvim_buf_create_user_command

    local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", lspbuf.rename, "[R]e[n]ame")
        nmap("<leader>ca", lspbuf.code_action, "[C]ode [A]ction")
        nmap("gd", lspbuf.definition, "[G]oto [D]efinition")
        nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
        nmap("gI", lspbuf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", lspbuf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        nmap("K", lspbuf.hover, "Hover Documentation")
        nmap("<C-k>", lspbuf.signature_help, "Signature Documentation")
        -- Lesser used LSP functionality
        nmap("gD", lspbuf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", lspbuf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", lspbuf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function() print(vim.inspect(lspbuf.list_workspace_folders())) end,
            "[W]orkspace [L]ist Folders")
        usrcommand(bufnr, "Format", function(_) lspbuf.format() end, { desc = "Format current buffer with LSP" })
    end

    local servers = {
        "bashls",
        "clangd",
        "gopls",
        "emmet_language_server",
        "pyright",
        "tsserver",
        "lua_ls",
        "texlab",
        "phpactor", }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("neodev").setup()
    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = servers })

    local handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
        -- language specific handler
        ["clangd"] = function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                autostart = false,
            })
        end,
        ["lua_ls"] = function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    }
                },
                capabilities = capabilities,
            })
        end,
        ["phpactor"] = function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                init_actions = {
                    ["language_server_phpstan.enabled"] = false,
                    ["language_server_psalm.enabled"] = true,
                    ["language_server_php_cs_fixer.enabled"] = true,
                    ["language_server_completion.trim_leading_dollar"] = true,
                    ["language_server.diagnostics_on_update"] = false,
                    ["indexer.exclude_patterns"] = '["/vendor/**/Tests/**/*","/vendor/**/tests/**/*","/var/cache/**/*","/vendor/composer/**/*","/tests/**/*"]'
                },
                capabilities = capabilities,
            })
        end,

    }

    require("mason-lspconfig").setup_handlers(handlers)

    -- UI Customization
    local lsph = vim.lsp.handlers
    local lspw = vim.lsp.with
    lsph["textDocument/hover"] = lspw(lsph.hover, { border = "rounded" })
    lsph["textDocument/signatureHelp"] = lspw(lsph.signature_help, { border = "rounded" })
    vim.diagnostic.config({ float = { border = "rounded" } })
    require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
