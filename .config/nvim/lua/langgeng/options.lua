local o = vim.opt
local g = vim.g

o.hlsearch = false
o.incsearch = true
o.showmode = false

-- Indenting
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false
o.relativenumber = true
o.cursorline = true

o.shortmess:append "I"
o.guicursor = ""
o.signcolumn = "yes"
o.colorcolumn = "80"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400

o.swapfile = false
o.backup = false
o.undofile = true
-- o.undodir = vim.fn.expand("~/.cache/nvim/undodir")

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append "<>[]hl"

-- interactive shell
o.shellcmdflag = "-ic"

o.wrap = false
o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append "@-@"

-- Set completeopt to have a better completion experience
o.completeopt = "menuone,noselect"

-- treesitter fold
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 1
o.foldenable = false -- Disable folding at startup.

o.mouse = ""
o.winbar = "%= %f %m %="
-- o.laststatus = 3

-- clipboard
g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
        ["*"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
    },
    cache_enabled = 0,
}

-- [[ autocmd & autogroup ]]
local augroup = vim.api.nvim_create_augroup
local on_save_group = augroup("langgeng", { clear = true })
local yank_group = augroup("HighlightYank", {})
local dart_format_group = augroup("DartFormat", { clear = true })

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
    group = dart_format_group,
    pattern = { "dart", "cpp" },
    callback = function()
        o.tabstop = 2
        o.shiftwidth = 2
        o.softtabstop = 2
    end
})
