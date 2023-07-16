local options = {
    -- transparent_background = true,
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        mason = true,
        treesitter = true,
        treesitter_context = true,
        harpoon = true,

        -- special
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        }
    },
}

return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    build = ":CatppuccinCompile",

    -- config = function()
    --     require("catppuccin").setup(options)
    -- end,
}
