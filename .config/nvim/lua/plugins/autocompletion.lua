local M = {
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        "hrsh7th/cmp-buffer",

        -- Adds LSP completion capabilities
        "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp-signature-help",
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
            completeopt = "menu,menuone,preview,noinsert",
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-Space>"] = cmp.mapping.complete {},
            ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
            ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "nvim_lsp_signature_help" },
            { name = "async_path" },
            { name = "buffer",                 keyword_length = 5 },
            { name = "emoji" }, -- trigger by typing `:`
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[snip]",
                    async_path = "[path]",
                    cmdline = "[cmd]",
                    buffer = "[buf]",
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
end

return M
