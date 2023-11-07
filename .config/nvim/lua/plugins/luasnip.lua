local M
M = {
    "L3MON4D3/LuaSnip",
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    event = "InsertEnter",
}

M.dependencies = {
    -- "rafamadriz/friendly-snippets",
    -- config = function()
    --     require("luasnip.loaders.from_vscode").lazy_load()
    -- end
}

M.opts = {
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    delete_check_events = "TextChanged",
}

M.config = function()
    local map = vim.keymap.set
    local ls = require("luasnip")
    local lazyload = require("luasnip.loaders.from_lua").lazy_load

    ls.config.set_config({
        history = true,
        update_events = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        delete_check_events = "TextChanged",
        store_selection_keys = "<Tab>",
    })

    lazyload({ paths = { "~/.config/nvim/lua/LuaSnip/", } })

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
    vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>")
end

return M
