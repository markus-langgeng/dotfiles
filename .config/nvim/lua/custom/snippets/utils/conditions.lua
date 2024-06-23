local make_cond = require("luasnip.extras.conditions").make_condition
local expand = require("luasnip.extras.conditions.expand")

local fexists = vim.fn.filereadable
local system = vim.system

local M = {}

local line_begin_show = function()
    local first_col_to_cursor = vim.fn.getline("."):sub(1, vim.fn.col(".") - 1)
    print(first_col_to_cursor:match("^%s*%w*$") ~= nil)
    return (first_col_to_cursor:match("^%s*%w*$") ~= nil)
end

-- M.line_begin = make_cond(line_begin_show)
M.first_line = make_cond(function() return (vim.fn.line(".") == 1) end)

M.latex = {}
M.line_begin = expand.line_begin -- cannot be used for show_condition
M.line_end = expand.line_end
M.line_begin_show = make_cond(function() line_begin_show() end)

local in_env = function(env)
    local is_inside = vim.fn["vimtex#env#is_inside"](env)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local document = function()
    local curfile = vim.fn.expand("%:t")
    if curfile == "packages.tex" or curfile == "preamble.tex" then
        return false
    end

    return in_env("document")
end

local lists_env = function()
    return in_env("itemize") or M.in_env("description") or M.in_env("enumerate") or M.in_env("thebibliography")
end

M.latex.env = {}
M.latex.env.document = make_cond(function() return document() end)
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
        local current_buffer = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for _, line in ipairs(current_buffer) do
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

-- M.latex.pkg = make_cond(function(pkg)
--     -- print(vim.inspect(has_pkg(pkg)))
--     return has_pkg(pkg)
-- end)

M.latex.pkg = {}
M.latex.pkg.xpinyin = make_cond(function() return has_pkg("xpinyin") end)
M.latex.pkg.tikz = make_cond(function() return has_pkg("tikz") end)
M.latex.pkg.fontspec = make_cond(function() return has_pkg("fontspec") end)
M.latex.pkg.graphicx = make_cond(function() return has_pkg("graphicx") end)
M.latex.pkg.biblatex = make_cond(function() return has_pkg("biblatex") end)
M.latex.pkg.polyglossia = make_cond(function() return has_pkg("polyglossia") end)
M.latex.pkg.glossaries = make_cond(function() return has_pkg("glossaries") end)

return M
