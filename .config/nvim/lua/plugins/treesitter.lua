local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
}

M.dependencies = {
    "andymass/vim-matchup",
}

local ensure = { "lua", "vimdoc", "vim", "comment", "diff", "c", "jsdoc"}
local ignore = { "latex" }

M.opts = {
    ensure_installed = ensure,
    ignore_install = ignore,
    sync_install = false,
    highlight = { enable = true },
    indent = {
        enable = true,
        disable = { "python", "latex" },
    },
    matchup = { enable = true },
}

M.config = function()
    require("nvim-treesitter.configs").setup(M.opts)
end

return M
