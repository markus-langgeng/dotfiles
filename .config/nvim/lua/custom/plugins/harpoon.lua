return {
    "ThePrimeagen/harpoon",
    dependencies = {
        { "nvim-lua/plenary.nvim" },     --lazy load this when required
    },
    keys = {
        { "<leader>h" },
        { "<leader>ha" },
        { "<leader>nn" },
        { "<leader>np" },
        { "<leader>na" },
        { "<leader>nb" },
        { "<leader>nc" },
        { "<leader>nd" },
        { "<leader>ne" },
    },
    config = function()
        require("custom.harpoon")
    end
}
