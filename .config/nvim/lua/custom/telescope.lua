local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

require("telescope").setup({
    defaults = {
        mappings = {
            n = {
                ["<M-p>"] = layout.toggle_preview,
            },
            i = {
                ["<ESC>"] = actions.close,
                -- ["<C-u>"] = false,
                ["<M-p>"] = layout.toggle_preview,
            },
        },
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
        history = {
            path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
            limit = 100,
        },
    },

    extensions = {
        wrap_results = true,
    },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Current buffer fuzzy find" })

map("n", "<leader>sf", builtin.find_files, { desc = "Telescope: [F]iles" })
map("n", "<leader>sf", builtin.find_files, { desc = "Telescope: [F]iles" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Telescope: [H]elp" })
map("n", "<leader>sm", builtin.man_pages, { desc = "Telescope: [M]an" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Telescope: [K]eymap" })
map("n", "<leader>sw", builtin.grep_string, { desc = "Telescope: Grep [w]ord under the cursor" })
map("n", "<leader>sg", builtin.live_grep, { desc = "Telescope: [G]rep string accross files" })

map("n", "<leader>shl", builtin.highlights, { desc = "Telescope: [H]ighlights" })
map("n", "<leader>sop", builtin.vim_options, { desc = "Telescope: [O]ptions" })
map("n", "<leader>smx", builtin.marks, { desc = "Telescope: [M]arks" })

map("n", "<leader>sc", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope: [C]onfig" })
