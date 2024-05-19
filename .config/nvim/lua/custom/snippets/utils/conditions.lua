local make_cond = require("luasnip.extras.conditions").make_condition
local expand = require("luasnip.extras.conditions.expand")

local fexists = vim.fn.filereadable
local curfile = vim.fn.expand("%:t")

local M = {}

local line_begin_show = function()
    local first_col_to_cursor = vim.fn.getline("."):sub(1, vim.fn.col(".") - 1)
    -- this will never work because as soon as I type the trigger, then it will
    -- no longer be on the beginning of te line
    -- How stupid am I?? debugging for hours :(
    -- You know what, after revisiting this function, I decided to add 2
    -- optional character after the space
    return (first_col_to_cursor:match("^%s*.?.?$") ~= nil)
end

-- M.line_begin = make_cond(line_begin_show)
M.first_line = make_cond(function() return (vim.fn.line(".") == 1) end)

M.latex = {}
M.line_begin = expand.line_begin -- cannot be used for show_condition
M.line_end = expand.line_end
M.line_begin_show = make_cond(line_begin_show)

local in_env = function(env)
    local is_inside = vim.fn["vimtex#env#is_inside"](env)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local document = function()
    local has_mainf = fexists("main.tex") == 1
    local has_preamf = (fexists("main.tex") == 1) and (fexists("preamble.tex") == 1)
    local is_multif = has_mainf or has_preamf
    local in_regularf = is_multif and (curfile ~= "main.tex") and (curfile ~= "preamble.tex")

    if in_regularf then
        return true
    end
    return in_env("document")
end

local lists_env = function()
    return in_env("itemize") or M.in_env("description") or M.in_env("enumerate") or M.in_env("thebibliography")
end

M.latex.env = {}
M.latex.env.document = make_cond(document)
M.latex.env.preamble = make_cond(function() return not document() end)
M.latex.env.lists_env = make_cond(lists_env)
M.latex.env.tikz = make_cond(function() return in_env("tikz") end)
M.latex.env.bibliography = make_cond(function() return in_env("thebibliography") end)
M.latex.env.itemize = make_cond(function() return in_env("itemize") end)
M.latex.env.enumerate = make_cond(function() return in_env("enumerate") end)
M.latex.env.description = make_cond(function() return in_env("description") end)
M.latex.env.equation = make_cond(function() return in_env("equation") end)
M.latex.env.mathzone = make_cond(function() return vim.fn["vimtex#syntax#in_mathzone"]() == 1 end)
M.latex.env.comment = make_cond(function() return vim.fn["vimtex#syntax#in_comment"]() == 1 end)

local has_pkg = function(pkg)
    local bufnr = 0
    local check_lines = function(buf)
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for _, line in ipairs(lines) do
            if line:match("^\\usepackage%[?.*%]?{[%a*,%s?]*" .. pkg .. "[,%s?%a*]*}") then
                return true
            end
        end
        return false
    end

    if vim.fn.filereadable("preamble.tex") == 1 then
        bufnr = vim.fn.bufadd("preamble.tex")
        vim.fn.bufload(bufnr)
        return check_lines(bufnr)
    end

    if vim.fn.filereadable("main.tex") == 1 then
        bufnr = vim.fn.bufadd("main.tex")
        vim.fn.bufload(bufnr)
        return check_lines(bufnr)
    end

    return check_lines(bufnr)
end

M.latex.pkg = {}
M.latex.pkg.xpinyin = make_cond(function() return has_pkg("xpinyin") end)
M.latex.pkg.tikz = make_cond(function() return has_pkg("tikz") end)
M.latex.pkg.fontspec = make_cond(function() return has_pkg("fontspec") end)
M.latex.pkg.graphicx = make_cond(function() return has_pkg("graphicx") end)
M.latex.pkg.biblatex = make_cond(function() return has_pkg("biblatex") end)
M.latex.pkg.polyglossia = make_cond(function() return has_pkg("polyglossia") end)

return M
