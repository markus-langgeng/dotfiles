local map = vim.keymap.set

map("n", "<leader>f", ":!bibtex-tidy --curly --space=4 --blank-lines=true --trailing-commas=true --sort --quiet=true %<cr>",
    { silent = true, buffer = true })
