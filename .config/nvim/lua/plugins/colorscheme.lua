local M = {
    "rebelot/kanagawa.nvim",
    lazy = false,
}

M.config = function()
vim.cmd([[colorscheme kanagawa-dragon]])
end

return M
