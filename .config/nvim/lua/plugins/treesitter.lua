local M = {}
local ensure_installed = {
    "go",
    "cpp",
    "lua",
    "python",
    "typescript",
    "vimdoc",
    "vim",
    "html",
    "css",
    "scss",
    "comment",
    "diff",
    "regex",
    "markdown",
}

local setup = {
    ensure_installed = ensure_installed,
    sync_install = false,
    highlight = { enable = true },
    ignore_install = { "latex" },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            node_decremental = "<bs>",
            scope_incremental = "<c-s>",
        },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
    matchup = { enable = true, disable_virtual_text = true },
}

M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
}

M.keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>",      desc = "Shrink selection",   mode = "v" },
}

M.dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "andymass/vim-matchup",
    "nvim-treesitter/nvim-treesitter-context",
    "windwp/nvim-ts-autotag",

}

M.config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup(setup)
end

return M
