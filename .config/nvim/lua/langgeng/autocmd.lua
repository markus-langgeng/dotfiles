local o = vim.opt
local g = vim.g
local expand = vim.fn.expand

-- [[ autocmd & autogroup ]]
local augroup = vim.api.nvim_create_augroup
local on_save_group = augroup("langgeng", { clear = true })
local yank_group = augroup("HighlightYank", {})
local format_group = augroup("DartFormat", { clear = true })
local reload_config_group = augroup("ReloadConfig", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- Delete trailing space
autocmd({ "BufWritePre" }, {
    group = on_save_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ "BufWritePre" }, {
    group = on_save_group,
    pattern = "*",
    command = [[lua vim.lsp.buf.format()]],
})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- Stop auto comment on new line
autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        o.formatoptions = o.formatoptions - { "c", "r", "o" }
    end
})

autocmd({ "FileType" }, {
    group = format_group,
    pattern = { "dart", "cpp", "r" },
    callback = function()
        o.tabstop = 2
        o.shiftwidth = 2
        o.softtabstop = 2
    end
})

autocmd({ "BufWritePost" }, {
    group = reload_config_group,
    pattern = { "sxhkdrc" },
    command = [[!kill -10 $(pidof sxhkd)]]
})

autocmd({ "BufWritePost" }, {
    group = reload_config_group,
    pattern = { "xresources" },
    command = [[!xrdb $HOME/.config/X11/xresources]]
})
