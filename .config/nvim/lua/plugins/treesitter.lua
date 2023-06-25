return { -- Highlight, edit, and navigate code
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
        end,
        event = "BufReadPost",
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Shrink selection",   mode = "v" },
        },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", },
            { "JoosepAlviste/nvim-ts-context-commentstring", },
            { "andymass/vim-matchup", },
            { "nvim-treesitter/playground",                  cmd = "TSPlaygroundToggle" },
            { "nvim-treesitter/nvim-treesitter-context", },
            {
                -- xml and html autotag
                "windwp/nvim-ts-autotag",
                ft = {
                    "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx",
                    "jsx",
                    "rescript",
                    "xml",
                    "php",
                    "markdown",
                    "astro", "glimmer", "handlebars", "hbs"
                },
            },

        },
        opts = {
            ensure_installed = {
                "cpp",
                "lua",
                "python",
                "typescript",
                "vimdoc",
                "vim",
                "html",
                "css",
                "scss",
                "comment",
                "diff",
                "regex",
                "markdown",
            },
            ignore_install = { "latex" },
            highlight = {
                enable = true,
                disable = { "latex" },
            },
            indent = { enable = true, disable = { "python" } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    node_decremental = "<bs>",
                    scope_incremental = "<c-s>",
                },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            -- Treesitter Modules and Plugins
            matchup = {
                enable = true,
                disable_virtual_text = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
}
