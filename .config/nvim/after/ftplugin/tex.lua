local ol = vim.opt_local

ol.foldmethod = "expr"
ol.foldexpr = "vimtex#fold#level(v:lnum)"
ol.foldtext = "vimtex#fold#text()"
ol.foldenable = true
ol.foldlevel = 0
ol.colorcolumn = ""
