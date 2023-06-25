return {
    {
        "lervag/vimtex",
        ft = { "tex" },
        config = function()
            local g = vim.g
            local ol = vim.opt_local

            -- latex folding
            ol.foldmethod = "expr"
            ol.foldexpr = "vimtex#fold#level(v:lnum)"
            ol.foldtext = "vimtex#fold#text()"
            ol.foldlevel = 0
            ol.foldenable = true

            g.vimtex_view_general_viewer = "zathura"
            g.vimtex_imaps_enabled = 0
            g.vimtex_compiler_latexmk = {
                build_dir = "out",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }
        end
    },
}
