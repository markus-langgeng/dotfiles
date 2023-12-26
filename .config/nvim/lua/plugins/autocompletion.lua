local M = {
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        "L3MON4D3/cmp-luasnip-choice",

        -- Adds LSP completion capabilities
        "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "FelipeLema/cmp-async-path",
    },
    event = "InsertEnter",
}

M.config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-Space>"] = cmp.mapping.complete {},
            ["<C-y>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "luasnip_choice" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lsp_document_symbol", }, -- trigger by typing `/@` in the prompt
            { name = "async_path" },
            { name = "emoji" },                     -- trigger by typing `:`
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[snip]",
                    luasnip_choice = "[choice]",
                    async_path = "[path]",
                    cmdline = "[cmd]",
                    emoji = "[emoji]",
                })[entry.source.name]
                return vim_item
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        }
    })

    -- `/` cmdline setup
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" },
        })
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "async_path" },
            { name = "cmdline" },
        })
    })
end

return M
