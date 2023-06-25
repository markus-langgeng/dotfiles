local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- LazyVim config
local options = {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "zipPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "matchit",
                "matchparen",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
            },
        },
    },
    ui = {
        icons = {},
    },
}

require("lazy").setup("plugins", options)

-- import options
pcall(require, "langgeng")

vim.cmd("colorscheme kanagawa")
