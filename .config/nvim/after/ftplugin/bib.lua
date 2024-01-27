local map = vim.keymap.set

map("n", "<leader>f", ":!bibtex-tidy --curly --space=4 --blank-lines=true --trailing-commas=true --quiet=true %<cr>",
    { buffer = true })
