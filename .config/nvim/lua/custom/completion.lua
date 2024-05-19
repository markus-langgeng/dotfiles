vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- vim.opt.shortmess:append "c"

local cmp = require("cmp")

-- setup nvim-cmp
cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview,noinsert",
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<CR>"]  = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<C-Space>"] = cmp.mapping.complete {},
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
        { name = "async_path" },
        { name = "buffer",                 keyword_length = 5 },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[snip]",
                async_path = "[path]",
                cmdline = "[cmd]",
                buffer = "[buf]",
            })[entry.source.name]
            return vim_item
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    -- We need to tell nvim-cmp what to do with snippets
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})

-- setup luasnip
local set = vim.keymap.set
local ls = require("luasnip")
local lazyload = require("luasnip.loaders.from_lua").lazy_load

ls.setup({
    update_events = { "TextChanged", "TextChangedI" },
    enable_autosnippets = true,
    delete_check_events = "TextChanged",
    store_selection_keys = "<Tab>",
})

lazyload({ paths = { "~/.config/nvim/lua/custom/snippets/", } })

set({ "i", "s" }, "<C-s>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { desc = "Luasnip: Expand or jump to next snippet item if available (luasnip)", silent = true })

set({ "i", "s" }, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { desc = "Luasnip: Expand or jump to previous snippet item if available (luasnip)", silent = true })

set({ "i", "s" }, "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { desc = "Luasnip: Change choices in choice node snippet", silent = true})

set({ "n" }, "<leader>sl", function()
    require("luasnip.extras.snippet_list").open()
end, { desc = "Luasnip: Show [S]nippet [L]ist" })

-- map("n", "<leader><leader>s", function ()
--     require("luasnip.session.snippet_collection").clear_snippets()
--     require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
-- end, { desc = "Reload [S]nippets"} )

