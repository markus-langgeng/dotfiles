local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup
local system = vim.fn.system

local group_reload_conf = aug("ReloadConfig", { clear = true })
local group_ime = aug("IME", { clear = true })
local group_vimtex = aug("Close vimtex buffer", { clear = true })

au({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 50 })
    end
})

au({ "BufWritePre" }, { -- Delete trailing spaces
    pattern = "*",
    callback = function()
        local curpos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)
    end
})

au({ "BufWritePost" }, {
    group = group_reload_conf,
    pattern = { "sxhkdrc" },
    command = [[silent !kill -10 $(pidof sxhkd)]]
})

au({ "BufWritePost" }, {
    group = group_reload_conf,
    pattern = { "xresources" },
    command = [[silent !xrdb $HOME/.config/X11/xresources]]
})

-- set fcitx5 IME to us on escape
local fcitx5state = system("fcitx5-remote")
au({ "InsertLeave" }, {
    group = group_ime,
    pattern = { "*" },
    callback = function()
        fcitx5state = system("fcitx5-remote")
        vim.cmd('silent !fcitx5-remote -c')
    end
})

au({ "InsertEnter", "BufCreate", "BufEnter", "BufLeave" }, {
    group = group_ime,
    pattern = { "*" },
    callback = function()
        if fcitx5state == 2 then
            system("fcitx5-remote -o")
        end
    end,
})

-- -- do :bwipeout so that VimtexEventQuit can be used
-- -- see :h vimtex-events
-- au("QuitPre", {
--     group = group_vimtex,
--     pattern = { "tex", "bib" },
--     command = [[:%bwipeout]]
-- })
