local options = {
    transparent = true,
    colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
    },
    overrides = function(colors) -- add/modify highlights
        local theme = colors.theme

        return {
            WinSeparator = { fg = theme.ui.bg_p1 },
            LineNr = { fg = "#c5c9c5" },
            CursorLine = { bg = "none" },
            CursorLineNr = { bg = "none", },

            TelescopeBorder = { bg = "none" },

            -- git signs
            -- ref: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/gitsigns.lua
            GitSignsAdd = { bg = "none" },
            GitSignsChange = { bg = "none" },
            GitSignsDelete = { bg = "none" },
            GitSignsAddPreview = { bg = "none" },
            GitSignsDeletePreview = { bg = "none" },
            -- diagnostics
            DiagnosticSignHint = { bg = "none" },
            DiagnosticSignInfo = { bg = "none" },
            DiagnosticSignWarn = { bg = "none" },
            DiagnosticSignError = { bg = "none" },

            --[[ Transparent Floating Windows ]]
            -- NormalFloat = { bg = "none" },
            -- FloatBorder = { fg = theme.ui.float.fg_border, bg = "none" },
            -- FloatTitle = { bg = "none" },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },


            --[[ Dark completion (popup) menu ]]
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
        }
    end,
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "wave",
    }
}

return {
    "rebelot/kanagawa.nvim",
    -- lazy = true,     -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("kanagawa").setup(options)
    end,
}
