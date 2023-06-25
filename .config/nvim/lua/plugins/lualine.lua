return {
    {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        event = 'VeryLazy',
        opts = {
            options = {
                -- theme = 'catppuccin',
                icons_enabled = false,
                -- theme = 'palenight',
                component_separators = '|',
                section_separators = '',
                globalstatus = true,
            },
        },
    },
    -- icons
    -- { "nvim-tree/nvim-web-devicons", lazy = true },
}
