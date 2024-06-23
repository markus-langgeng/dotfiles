local set = vim.keymap.set
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Harpoon: Toggle quick menu" } )
set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: [A]dd files" } )

set("n", "<leader>nn", ui.nav_next, { desc = "Harpoon: [N]avigate [N]ext file" } )
set("n", "<leader>np", ui.nav_prev, { desc = "Harpoon: [N]avigate [P]rev file" } )

set("n", "<leader>na", function() ui.nav_file(1) end, { desc = "Harpoon: [N]avigate file 1" } )
set("n", "<leader>nb", function() ui.nav_file(2) end, { desc = "Harpoon: [N]avigate file 2" } )
set("n", "<leader>nc", function() ui.nav_file(3) end, { desc = "Harpoon: [N]avigate file 3" } )
set("n", "<leader>nd", function() ui.nav_file(4) end, { desc = "Harpoon: [N]avigate file 4" } )
set("n", "<leader>ne", function() ui.nav_file(5) end, { desc = "Harpoon: [N]avigate file 5" } )
