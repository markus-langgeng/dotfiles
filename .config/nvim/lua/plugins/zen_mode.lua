return {
    "folke/zen-mode.nvim",
    keys = {
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "[Z]enMode" },
    },
    config = function()
        require("zen-mode").setup()
    end
}
