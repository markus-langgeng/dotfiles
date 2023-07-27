local o = vim.opt
local ol = vim.opt_local
local g = vim.g
local expand = vim.fn.expand
local system = vim.fn.system

local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local on_save_group = aug("OnSave", { clear = true })
local yank_group = aug("HighlightYank", {})
local format_group = aug("DartFormat", { clear = true })
local reload_config_group = aug("ReloadConfig", { clear = true })
local ime = aug("IME", { clear = true })


-- Delete trailing space
au({ "BufWritePre" }, {
    group = on_save_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
au({ "BufWritePre" }, {
    group = on_save_group,
    pattern = "*",
    command = [[lua vim.lsp.buf.format()]],
})

au("TextYankPost", {
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
au({ "FileType" }, {
    pattern = "*",
    callback = function()
        o.formatoptions = o.formatoptions - { "c", "r", "o" }
    end
})

au({ "FileType" }, {
    group = format_group,
    pattern = { "dart", "cpp", "r" },
    callback = function()
        ol.tabstop = 2
        ol.shiftwidth = 2
        ol.softtabstop = 2
    end,
})

au({ "BufWritePost" }, {
    group = reload_config_group,
    pattern = { "sxhkdrc" },
    command = [[silent !kill -10 $(pidof sxhkd)]]
})
au({ "BufWritePost" }, {
    group = reload_config_group,
    pattern = { "xresources" },
    command = [[silent !xrdb $HOME/.config/X11/xresources]]
})


local fcitx5state = system("fcitx5-remote")
au({ "InsertLeave" }, {
    group = ime,
    pattern = { "*" },
    callback = function()
        fcitx5state = system("fcitx5-remote")
        vim.cmd('silent !fcitx5-remote -c')
    end
})
au({ "InsertEnter", "BufCreate", "BufEnter", "BufLeave" }, {
    group = ime,
    pattern = { "*" },
    callback = function()
        if fcitx5state == 2 then
            system("fcitx5-remote -o")
        end
    end,
})
