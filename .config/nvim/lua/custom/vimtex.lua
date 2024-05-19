local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup
local system = vim.fn.system
local g = vim.g

g.vimtex_view_method = "zathura"
g.vimtex_imaps_enabled = 0
g.vimtex_fold_enabled = 1
g.vimtex_fold_types = {
    preamble = { enabled = 1 },
}
g.vimtex_compiler_latexmk = {
    aux_dir = "aux",
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


-- -- see :h vimtex-events
-- local vimtex_event_1 = aug("Vimtex Event 1", { clear = true })
-- au("User", { group = vimtex_event_1, pattern = "VimtexEventQuit", command = [[silent! VimtexClean]] })
-- au("User", { group = vimtex_event_1, pattern = "VimtexEventQuit",
--     callback = function ()
--         local texfile = vim.fn.expand("*pdf")
--         local winid = system({"xdotool", "search", "--name", texfile})
--         if vim.fn.filereadable(texfile) and winid then
--             system({"xdotool", "search", "--name", texfile, "windowclose", "%@"})
--         end
--     end
-- })


