local M = {
    "L3MON4D3/LuaSnip", -- Snippets plugin
    event = "InsertEnter",
}

M.opts = {
    -- keep_roots = true,
    -- link_roots = true,
    -- link_children = true,
    update_events = { "TextChanged", "TextChangedI" },
    enable_autosnippets = true,
    delete_check_events = "TextChanged",
    store_selection_keys = "<Tab>",
}

M.config = function()
    local map = vim.keymap.set
    local ls = require("luasnip")
    local lazyload = require("luasnip.loaders.from_lua").lazy_load

    ls.setup(M.opts)

    lazyload({ paths = { "~/.config/nvim/lua/snippets", } })

    map({ "i", "s" }, "<C-s>", function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end, { desc = "Expand or jump to next snippet item if available (luasnip)" })

    map({ "i", "s" }, "<C-h>", function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end, { desc = "Expand or jump to previous snippet item if available (luasnip)" })

    map({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { desc = "Change choices in choice node snippet" })

    map({ "n" }, "<leader>sl", function()
        require("luasnip.extras.snippet_list").open()
    end, { desc = "Show [S]nippet [L]ist" })

    map("n", "<leader><leader>s", function ()
        require("luasnip.session.snippet_collection").clear_snippets()
        require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
    end, { desc = "Reload [S]nippets"} )
end

return M
