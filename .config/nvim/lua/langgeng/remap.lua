local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- map("v", "y", "ygv<esc>")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<CR>", "ciw")

map("x", "<leader>p", [["_dP]])

-- next greatest remap ever
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("v", ">", ">gv")
map("v", "<", "<gv")

map({ "n", "v" }, "<leader>d", [["_d]])

map("i", "jk", "<Esc>")
map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<leader>f", vim.lsp.buf.format)

map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "<leader>ox", function()
    local path = vim.fn.input({
        prompt = "Open Explorer in > ",
        default = "~",
        completion = "file",
    })
    if (path == nil or path == '') then return end
    vim.fn.system(string.format([[explorer.exe `wslpath -w "%s"`]], path))
end, { desc = "[O]pen File E[X]plorer from nvim" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
-- vk("n", "<leader>e", vim.diagnostic.open_float)
map("n", "<leader>q", vim.diagnostic.setloclist)
