return {
    -- ThePrimagen navigation plugin
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "[A]dd current file into Harpoon" },
        { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon's quick menu" },
        { "<C-h>",     function() require("harpoon.ui").nav_file(1) end,         desc = {} },
        { "<C-t>",     function() require("harpoon.ui").nav_file(2) end,         desc = {} },
        { "<C-n>",     function() require("harpoon.ui").nav_file(3) end,         desc = {} },
        { "<C-s>",     function() require("harpoon.ui").nav_file(4) end,         desc = {} },
    },
}
