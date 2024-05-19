return {
    { "nvim-lua/plenary.nvim" },
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-smart-history.nvim" },
            { "kkharji/sqlite.lua" },
        },
        event = "VeryLazy",
        config = function()
            require "custom.telescope"
        end
    },
}
