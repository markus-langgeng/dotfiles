local M = {}
M[1] = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    cmd = "Telescope",
    opts = {}
}

M[1].dependencies = { "nvim-lua/plenary.nvim", "xiyaowong/telescope-emoji.nvim", }

M[1].keys = {
    { "<leader>?",       "<cmd>Telescope oldfiles<CR>",    desc = "TLSC: [?] Find recently opened files" },
    { "<leader><space>", "<cmd>Telescope buffers<CR>",     desc = "TLSC: [ ] Find existing buffers" },
    { "<C-p>",           ":Telescope ",                    desc = "TLSC: Write :Telescope on the command prompt" },
    { "<leader>sf",      "<cmd>Telescope find_files<CR>",  desc = "TLSC: [S]earch [F]iles" },
    { "<leader>sh",      "<cmd>Telescope help_tags<CR>",   desc = "TLSC: [S]earch [H]elp" },
    { "<leader>sw",      "<cmd>Telescope grep_string<CR>", desc = "TLSC: [S]earch current [W]ord" },
    { "<leader>sg",      "<cmd>Telescope live_grep<CR>",   desc = "TLSC: [S]earch by [G]rep" },
    { "<leader>sd",      "<cmd>Telescope diagnostics<CR>", desc = "TLSC: [S]earch [D]iagnostics" },
    { "<leader>sgt",     "<cmd>Telescope git_files<CR>",   desc = "TLSC: [S]earch [G]i[T] files" },
    { "<leader>sop",     "<cmd>Telescope vim_options<CR>", desc = "TLSC: [S]earch all [OP]tions" },
    { "<leader>scm",     "<cmd>Telescope commands<CR>",    desc = "TLSC: [S]earch [C]o[M]mand" },
    { "<leader>skm",     "<cmd>Telescope keymaps<CR>",     desc = "TLSC: [S]earch [K]ey[M]aps" },
    { "<leader>shl",     "<cmd>Telescope highlights<CR>",  desc = "TLSC: [S]earch [H]igh[L]ights" },
    { "<leader>se",      "<cmd>Telescope emoji<CR>",       desc = "TLSC: [S]earch [E]moji" },
    {
        "<leader>/",
        function()
            local builtin = require("telescope.builtin")
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                previewer = false,
            })
        end,
        desc = "TLSC: [/] Fuzzily search in current buffer]"
    },
    {
        "<leader>scf",
        function()
            require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
        end,
        desc = "TLSC: [S]earch nvim [C]on[F]ig files"
    },
}

M[1].opts.defaults = {
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
}

-- [[ Telescope extensions ]]
M[2] = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
        require("telescope").load_extension("fzf")
    end
}

M[3] = {
    "xiyaowong/telescope-emoji.nvim",
    cmd = "Telescope emoji",
    config = function()
        require("telescope").load_extension("emoji")
    end
}

M[1].opts.extensions = {}
M[1].opts.extensions.emoji = {
    action = function(emoji)
        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)
        vim.api.nvim_put({ emoji.value }, "c", false, true)
    end
}

return M
