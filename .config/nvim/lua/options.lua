local o = vim.opt
local ol = vim.opt_local
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

-- Indenting
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.number = true
o.numberwidth = 2
o.relativenumber = true
o.cursorline = true
o.guicursor = ""
o.signcolumn = "yes"
o.colorcolumn = "80"
o.scrolloff = 8
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.mouse = ""
o.winbar = "%= %t %m %="
o.statusline = [[%!v:lua.require("statusline").statusline()]]
o.laststatus = 3
o.whichwrap:append("<>[]hl")       -- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
o.updatetime = 250                 -- interval for writing swap file to disk, also used by gitsigns
o.shellcmdflag = "-ic"             -- interactive shell
o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
o.hlsearch = false
o.incsearch = true
o.showmode = true
o.ignorecase = true
o.smartcase = true
o.wrap = false
o.isfname:append("@-@")

-- treesitter fold
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 1
o.foldenable = false -- Disable folding at startup.

-- undofile
-- o.swapfile = true
-- o.backup = false
-- o.undofile = true
-- o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
o.undofile = true
