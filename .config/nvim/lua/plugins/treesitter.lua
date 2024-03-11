local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
}

M.dependencies = {
    "andymass/vim-matchup",
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- "nvim-treesitter/nvim-treesitter-context",
    "numToStr/Comment.nvim",
}

local ensure = { "lua", "vimdoc", "vim", "comment", "diff", "c", "jsdoc" }
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
    vim.g.matchup_override_vimtex = 1
    vim.g.skip_ts_commentstring_module = true
    vim.g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, scrolloff = 4, syntax_hl = 1 }
    require("ts_context_commentstring").setup { enable_autocmd = false, }
    require("Comment").setup { pre_hook =
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
end

return M
