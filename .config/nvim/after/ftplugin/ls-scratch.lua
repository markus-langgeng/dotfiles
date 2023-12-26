local map = vim.keymap.set
local norm = vim.cmd.norm

map("n", "<leader>le", function() norm("I:e ") end, { desc = "Edit file", buffer = true })
map("n", "<leader>lm", function() norm("I:!mv Y$pvT/") end, { desc = "Move file", buffer = true })
map("n", "<leader>lc", function() norm("I:!cp Y$pvT/") end, { desc = "Copy file", buffer = true })
map("n", "<leader>lr", function() norm("I:!rm ") end, { desc = "Remove file", buffer = true })
map("n", "<leader>rc", function() norm([["lyy@l]]) end, { desc = "Run command", buffer = true })
