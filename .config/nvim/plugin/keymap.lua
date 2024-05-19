local set = vim.keymap.set

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")
set("v", "y", "ygv<esc>")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<C-k>", "<cmd>cprev<CR>zz")
set("n", "<C-j>", "<cmd>cnext<CR>zz")

set("x", "<leader>p", [["_dP]])

-- next greatest remap ever
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])
set("v", ">", ">gv")
set("v", "<", "<gv")

set({ "n", "v" }, "<leader>d", [["_d]])

set("i", "<C-c>", "<Esc>")

set("n", "Q", "<nop>")
set("n", "<leader>f", vim.lsp.buf.format)

set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

set("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

set("n", "<M-,>", "<c-w>5>")
set("n", "<M-.>", "<c-w>5<")
set("n", "<M-l>", "<C-W>+") -- long
set("n", "<M-s>", "<C-W>-") -- short

set("n", "<leader><leader>s", "<CMD>source %<CR>")

-- Diagnostic keymaps
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "DIAG: Show diagnostic [E]rror on float window" })
set("n", "[d", vim.diagnostic.goto_prev, { desc = "DIAG: Go to previous diagnostic" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "DIAG: Go to next diagnostic" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "DIAG: Make [Q]uickfixlist from diagnostic" })
