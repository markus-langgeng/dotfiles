-- dark colorschemes (it's good enough): torte, koehler, pablo*, habamax*, industry, lunaperche*
-- vim.cmd("colorscheme habamax")
require("options") -- add options on top because of definition of leaders key
require("remap")
require("autocmd")

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

-- see :h standard-plugin-list
local opts = { -- lazy vim config opts
    performance = {
        rtp = {
            disabled_plugins = {
                -- "editorconfig",
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "rplugin",
                "spellfile",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        }
    },
    ui = {
        border = "rounded",
        icons = {
            cmd = "[cmd]",
            config = "[config]",
            event = "[event]",
            ft = "[ft]",
            init = "[init]",
            import = "[import]",
            keys = "[keys]",
            lazy = "[lazy]",
            loaded = "[load]",
            not_loaded = "[not_loaded]",
            plugin = "[plugin]",
            runtime = "[runtime]",
            require = "[require]",
            source = "[source]",
            start = "[start]",
            task = "[task]",
            list = {
                ">",
                "*",
                "~",
                "-",
            },
        },
    }
}

require("lazy").setup("plugins", opts) -- search directory called "plugins"
require("highlights")
