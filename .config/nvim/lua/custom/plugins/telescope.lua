return {
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" }, --lazy load this when required
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-smart-history.nvim" },
            { "kkharji/sqlite.lua" },
        },
        -- keys = {
        --     { "<leader>/" },
        --     { "<leader>sf" },
        --     { "<leader>sf" },
        --     { "<leader>sh" },
        --     { "<leader>sm" },
        --     { "<leader>sk" },
        --     { "<leader>sw" },
        --     { "<leader>sg" },
        --     { "<leader>shl" },
        --     { "<leader>sop" },
        --     { "<leader>smx" },
        --     { "<leader>sc" },
        -- },
        config = function()
            require "custom.telescope"
        end
    },
}
