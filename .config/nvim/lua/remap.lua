local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "y", "ygv<esc>")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<C-k>", "<cmd>cprev<CR>zz")
map("n", "<C-j>", "<cmd>cnext<CR>zz")

map("x", "<leader>p", [["_dP]])

-- next greatest remap ever
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("v", ">", ">gv")
map("v", "<", "<gv")

map({ "n", "v" }, "<leader>d", [["_d]])

map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<leader>f", vim.lsp.buf.format)

map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Diagnostic keymaps
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "DIAG: Show diagnostic [E]rror on float window" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "DIAG: Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "DIAG: Go to next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "DIAG: Make [Q]uickfixlist from diagnostic" })
