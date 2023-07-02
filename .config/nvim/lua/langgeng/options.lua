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
o.clipboard:append "unnamedplus"
