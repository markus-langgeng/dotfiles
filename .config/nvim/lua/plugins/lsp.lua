local M = {
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
}

M.dependencies = {
    -- LSP Configuration & Plugins
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} }, -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
    { "folke/neodev.nvim", opts = {} },
}

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = "LSP: " .. desc end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question
local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
        },
    },

    clangd = {},
    texlab = {},
}

M.config = function()
    -- Configure LSP
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require("mason").setup({
        ui = {
            border = "rounded",
            icons = {
                package_installed = "[v]",
                package_pending = "[~]",
                package_uninstalled = "[x]",
            },
        },
    })
    require("mason-lspconfig").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require "mason-lspconfig"

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            if server_name == "clangd" then
                require("lspconfig")[server_name].setup({
                    autostart = false,
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                })
            elseif server_name == "phpactor" then
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    init_actions = {
                        ["language_server_phpstan.enabled"] = false,
                        ["language_server_psalm.enabled"] = true,
                        ["language_server_php_cs_fixer.enabled"] = true,
                        ["language_server_completion.trim_leading_dollar"] = true,
                        ["language_server.diagnostics_on_update"] = false,
                        ["indexer.exclude_patterns"] =
                        '["/vendor/**/Tests/**/*","/vendor/**/tests/**/*","/var/cache/**/*","/vendor/composer/**/*","/tests/**/*","/vendor/**"]',
                    },
                })
            else
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end
        end,
    }
end

-- UI Customization
local lsph = vim.lsp.handlers
local lspw = vim.lsp.with
lsph["textDocument/hover"] = lspw(lsph.hover, { border = "rounded" })
lsph["textDocument/signatureHelp"] = lspw(lsph.signature_help, { border = "rounded" })
vim.diagnostic.config({ float = { border = "rounded" } })
require("lspconfig.ui.windows").default_options.border = "rounded"

return M
