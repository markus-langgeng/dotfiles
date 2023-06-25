return {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "FelipeLema/cmp-async-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/cmp-luasnip-choice",
    },
    opts = function()
        local cmp = require("cmp")
        return {
            completion = {
                completeopt = "menu,menuone,noselect"
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-c>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true, select
                },
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "luasnip_choice" },
                { name = "async_path" },
                { name = "buffer",        keyword_length = 4 },
            }),
            formatting = {
                format = function(entry, item)
                    item.menu = ({
                        buffer = "[buf]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[API]",
                        async_path = "[path]",
                        luasnip = "[snip]",
                        luasnip_choice = "[snip_choice]",
                    })[entry.source.name]
                    return item
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }
    end,
}
