require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vimdoc", "vim", "comment", "diff", "c", "jsdoc" },
    ignore_install = { "latex" },
    sync_install = false,
    highlight = { enable = true },
    indent = {
        enable = true,
        disable = { "python", "latex" },
    },
    matchup = { enable = true },
})

vim.g.matchup_override_vimtex = 1
-- vim.g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, scrolloff = 4, syntax_hl = 1 }
vim.g.skip_ts_commentstring_module = true --  backwards compatibility routines and speed up loading.

require("ts_context_commentstring").setup({ enable_autocmd = false, })
require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
