return {
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    dependencies = {
        -- LSP Configuration & Plugins
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} }, -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        require("custom.lsp")
    end
}
