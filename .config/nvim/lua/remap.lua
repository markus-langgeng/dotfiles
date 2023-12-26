local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "y", "ygv<esc>")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "[q", "<cmd>cprev<CR>")
map("n", "]q", "<cmd>cnext<CR>")

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
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- Simple file operation
-- Thanks to 🙏 Theodore Alenas for the trick
-- Execute command that is typed in a buffer
-- 1. Type `"s` to save command to a register (s for shell)
-- 2. Type `Shift+D` or `Shift+Y` to save the command/text
-- 3. Type `@c` to play the register
map("n", "<leader>ls", function()
    vim.cmd("vsplit | enew")
    vim.opt_local.buftype = "nofile"
    vim.opt_local.bufhidden = "hide"
    vim.opt_local.swapfile = false
    vim.opt_local.buflisted = false
    vim.opt_local.filetype = "ls-scratch"
    local custom_find = {
        [[.!find ./]],
        [[-not \( -wholename "*/.git" -prune \)]],
        [[-not \( -wholename "*/node_modules" -prune \)]],
        [[-type f]],
        [[2>/dev/null]],
        [[| sed 's/^.\///g']],
    }
    vim.cmd(table.concat(custom_find, " "))
end, { desc = "Do vsplit+enew and `find` files" })
