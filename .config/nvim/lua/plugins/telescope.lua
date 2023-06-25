return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        cmd = "Telescope",
        dependencies = {
            -- these dependencies will only be loaded when telescope loads
            -- dependencies are always lazy-loaded unless specified otherwise
            {
                "nvim-lua/plenary.nvim",
                -- "nvim-telescope/telescope-fzf-native.nvim",
                -- "nvim-telescope/telescope-file-browser.nvim",
                -- "xiyaowong/telescope-emoji.nvim",
            },
        },
        keys = {
            -- [[ Default Kickstart mapping ]]
            -- See `:help telescope.builtin`
            { "<leader>?",       "<cmd>Telescope oldfiles<CR>", desc = "[?] Find recently opened files" },
            { "<leader><space>", "<cmd>Telescope buffers<CR>",  desc = "[ ] Find existing buffers" },
            {
                "<leader>/",
                function()
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                        -- winblend = 10,
                        previewer = false,
                    })
                end,
                desc = "[/] Fuzzily search in current buffer]"
            },

            { "<leader>sf",  "<cmd>Telescope find_files<CR>",  desc = "[S]earch [F]iles" },
            { "<leader>sh",  "<cmd>Telescope help_tags<CR>",   desc = "[S]earch [H]elp" },
            { "<leader>sw",  "<cmd>Telescope grep_string<CR>", desc = "[S]earch current [W]ord" },
            { "<leader>sg",  "<cmd>Telescope live_grep<CR>",   desc = "[S]earch by [G]rep" },
            { "<leader>sd",  "<cmd>Telescope diagnostics<CR>", desc = "[S]earch [D]iagnostics" },

            -- [[ My mapping ]]
            { "<C-p>",       ":Telescope ",                    desc = "Write :Telescope on the command prompt" },
            { "<leader>sgt", "<cmd>Telescope git_files<CR>",   desc = "[S]earch [G]i[T] files" },
            {
                "<leader>scf",
                function()
                    require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
                end,
                desc = "[S]earch nvim [C]on[F]ig files"
            },
            { "<leader>sop", "<cmd>Telescope vim_options<CR>", desc = "[S]earch all [OP]tions" },
            { "<leader>scm", "<cmd>Telescope commands<CR>",    desc = "[S]earch [C]o[M]mand" },
            { "<leader>skm", "<cmd>Telescope keymaps<CR>",     desc = "[S]earch [K]ey[M]aps" },
            { "<leader>shl", "<cmd>Telescope highlights<CR>",  desc = "[S]earch [H]igh[L]ights" },
            -- {
            --     "<leader>scp",
            --     function()
            --         require("telescope.builtin").find_files({
            --             cwd = vim.fn.input({
            --                 prompt = "Search on dir > ",
            --                 default = "~",
            --                 comletion = "dir",
            --             })
            --         })
            --     end,
            --     desc = "[S]earch + [C]hange directory to specified [P]ath"
            -- },
        },
        opts = {
            -- See `:help telescope` and `:help telescope.setup()`
            defaults = {
                path_display = { shorten = { len = 1, } },
                preview = { treesitter = true, },
                dynamic_preview_title = true,
                file_ignore_patterns = {
                    "node%_modules/.*",
                    "vendor/.*",
                    ".git/",
                    "gradle/.*",
                    "%.jpg",
                    "%.jpeg",
                    "%.png",
                    "%.otf",
                    "%.ttf",
                },
            },
            extensions = {
                emoji = {
                    action = function(emoji)
                        vim.fn.setreg("*", emoji.value)
                        print([[Press p or "*p to paste this emoji]] .. emoji.value)

                        -- insert emoji when picked
                        vim.api.nvim_put({ emoji.value }, "c", false, true)
                    end
                }
            },
        },
    },

    -- telescope extensions
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end
    },
    {
        "xiyaowong/telescope-emoji.nvim",
        cmd = "Telescope emoji",
        keys = {
            { "<leader>se", "<cmd>Telescope emoji<CR>", desc = "[S]earch [E]moji" },
        },
        config = function()
            require("telescope").load_extension("emoji")
        end
    },
}
