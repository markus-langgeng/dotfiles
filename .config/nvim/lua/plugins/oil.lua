return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "<leader>pv", function() require("oil").open() end, desc = "Explore directory 📂 with coconut oil" },
    },
    opts = {
        win_options = {
            signcolumn = "yes",
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = false,
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["cd"] = "actions.cd",
            ["~"] = "actions.tcd",
            -- my keymaps
            ["<C-s>"] = "actions.select_split",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.toggle_hidden",
        }
    },
}
