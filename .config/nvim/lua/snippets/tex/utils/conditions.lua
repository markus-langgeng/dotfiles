---@diagnostic disable: undefined-global

local make_condition = require("luasnip.extras.conditions").make_condition

-- see :h luasnip-conditions
local M = {}

-- generic environment detection
local in_env = function(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local has_pkg = function (name)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        if line:match("^\\usepackage%[?.*%]?{[%a*,%s?]*" .. name .. "[,%s?%a*]*}") then
            return true
        end
    end
    return false
end

local even_line = function()
    local line_number = vim.fn["line"](".")
    return ((line_number % 2) == 0)
end

local first_line = function()
    local line_number = vim.fn["line"](".")
    return (line_number == 1)
end

local preamble = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local pos1, pos2
    local cursor_line = unpack(vim.api.nvim_win_get_cursor(0))
    for n, line in ipairs(lines) do
        if line:match("^\\documentclass.*") then
            pos1 = n
        elseif line:match("^\\begin{document}") then
            pos2 = n
        end
    end
    if pos1 ~= nil and pos2 ~= nil and cursor_line > pos1 and cursor_line < pos2 then
        return true
    end
    return false
end

local mathzone = function() return vim.fn["vimtex#syntax#in_mathzone"]() == 1 end
local document = function() return in_env("document") end
local comment = function() return vim.fn["vimtex#syntax#in_comment"]() == 1 end
local equation = function() return in_env("equation") end
local itemize = function() return in_env("itemize") end
local enumerate = function() return in_env("enumerate") end
local description = function() return in_env("description") end
local bullets = function() return in_env("itemize") or in_env("enumerate") end

local bib_env = function() return in_env("thebibliography") end
local tikz_env = function() return in_env("tikzpicture") end
local xpinyin = function() return has_pkg("xpinyin") end
local fontspec = function() return has_pkg("fontspec") end
local graphicx = function() return has_pkg("graphicx") end
local biblatex = function() return has_pkg("biblatex") end

local list_env = function()
    return in_env("itemize") or in_env("description") or in_env("enumerate") or
        in_env("thebibliography")
end

M.is_even_line = make_condition(even_line)
M.on_first_line = make_condition(first_line)

M.line_begin = make_condition(require("luasnip.extras.conditions.expand").line_begin)
M.line_end = make_condition(require("luasnip.extras.conditions.expand").line_end)

-- M.in_text = make_condition(text)
M.in_preamble = make_condition(preamble)
M.in_comment = make_condition(comment)
M.in_document = make_condition(document)

-- Maths related environments
M.in_mathzone = make_condition(mathzone)
M.in_equation = make_condition(equation)

-- Environments that have \item command
M.in_itemize = make_condition(itemize)
M.in_enumerate = make_condition(enumerate)
M.in_description = make_condition(description)
M.in_bullets = make_condition(bullets)
M.in_list_env = make_condition(list_env)

M.in_bib = make_condition(bib_env)
M.in_tikz = make_condition(tikz_env)
M.has_xpinyin = make_condition(xpinyin)
M.has_fontspec = make_condition(fontspec)
M.has_graphicx = make_condition(graphicx)
M.has_biblatex = make_condition(biblatex)

return M
