return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        "andymass/vim-matchup",
        "numToStr/Comment.nvim",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("custom.treesitter")
    end
}
