local M = {}

M = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    cmd = "Telescope",
}

M.dependencies = {
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end
    }
}

M.opts = {
    defaults = {
        -- path_display = { shorten = { len = 1, } },
        preview = { treesitter = true, },
        dynamic_preview_title = true,
        file_ignore_patterns = {
            "node_modules/.*",
            "vendor/.*",
            ".git/",
            "gradle/.*",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.otf",
            "%.ttf",
            "%.pdf",
            "%.doc*",
        },
    }
}

M.keys = {
    { "<leader>?",       "<cmd>Telescope oldfiles<CR>",    desc = "TLSC: [?] Find recently opened files" },
    { "<leader><space>", "<cmd>Telescope buffers<CR>",     desc = "TLSC: [ ] Find existing buffers" },
    { "<C-p>",           ":Telescope ",                    desc = "TLSC: Write :Telescope on the command prompt" },
    { "<leader>sf",      "<cmd>Telescope find_files<CR>",  desc = "TLSC: [S]earch [F]iles" },
    { "<leader>sh",      "<cmd>Telescope help_tags<CR>",   desc = "TLSC: [S]earch [H]elp" },
    { "<leader>sw",      "<cmd>Telescope grep_string<CR>", desc = "TLSC: [S]earch current [W]ord" },
    { "<leader>sg",      "<cmd>Telescope live_grep<CR>",   desc = "TLSC: [S]earch by [G]rep" },
    { "<leader>sd",      "<cmd>Telescope diagnostics<CR>", desc = "TLSC: [S]earch [D]iagnostics" },
    { "<leader>sgi",     "<cmd>Telescope git_files<CR>",   desc = "TLSC: [S]earch [GI]t files" },
    { "<leader>sop",     "<cmd>Telescope vim_options<CR>", desc = "TLSC: [S]earch all [OP]tions" },
    { "<leader>scm",     "<cmd>Telescope commands<CR>",    desc = "TLSC: [S]earch [C]o[M]mand" },
    { "<leader>skm",     "<cmd>Telescope keymaps<CR>",     desc = "TLSC: [S]earch [K]ey [M]aps" },
    { "<leader>shl",     "<cmd>Telescope highlights<CR>",  desc = "TLSC: [S]earch [H]igh[L]ights" },
    { "<leader>sm",      "<cmd>Telescope man_pages<CR>",   desc = "TLSC: [S]earch [M]an Pages" },
    {
        "<leader>/",
        function()
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")
            builtin.current_buffer_fuzzy_find(
                themes.get_dropdown({ previewer = false, })
            )
        end,
        desc = "TLSC: [/] Fuzzily search in current buffer]"
    },
    {
        "<leader>scf",
        function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "TLSC: [S]earch nvim [C]on[F]ig files"
    },
}

return M
