return {
    {
        "hrsh7th/nvim-cmp", -- Autocompletion plugin
        dependencies = {

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "FelipeLema/cmp-async-path",
        },
        -- event = "InsertEnter",
        config = function()
            require("custom.completion")
        end
    },
    {
        -- Snippet Engine & its associated nvim-cmp source
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "hrsh7th/cmp-buffer",
        },
    },
}
