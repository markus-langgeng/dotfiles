---@diagnostic disable: undefined-global

-- see :h luasnip-conditions
local M = {}

M.line_begin = require("luasnip.extras.expand_conditions").line_begin
M.line_end = require("luasnip.extras.expand_conditions").line_end

M.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

M.in_comment = function() -- comment detection
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

M.has_xpinyin = function()
    local exists = vim.fn.search([[^\\usepackage{xeCJK, xpinyin}]])
    return exists ~= 0
end

M.is_even_line = function()
    local line_number = vim.fn["line"](".")
    return ((line_number % 2) == 0)
end

M.on_first_line = function()
    local line_number = vim.fn["line"](".")
    return (line_number == 1)
end

-- generic environment detection
M.in_env = function(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_preamble()
    return not M.in_env("document")
end

M.in_text = function()
    return not M.in_mathzone() and not M.in_env("document")
end

-- A few concrete environments---adapt as needed
M.in_equation = function() return M.in_env("equation") end

-- Environments that have \item command
M.in_itemize = function()
    return M.in_env("itemize")
end
M.in_enumerate = function()
    return M.in_env("enumerate")
end
M.in_description = function()
    return M.in_env("description")
end
M.in_bib = function()
    return M.in_env("thebibliography")
end
M.in_bullets = function()
    return M.in_env("itemize") or M.in_env("enumerate")
end
M.in_list_env = function()
    return M.in_env("itemize") or M.in_env("description") or M.in_env("enumerate") or M.in_env("thebibliography")
end
M.in_tikz = function()
    return M.in_env("tikzpicture")
end

return M
