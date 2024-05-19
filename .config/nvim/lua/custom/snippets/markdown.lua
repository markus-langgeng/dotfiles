---@diagnostic disable: undefined-global

local helper = require("custom.snippets.utils.helper")
local cond = require("custom.snippets.utils.conditions")

---@param lvl number
---@return function
local heading = function(lvl)
    return s({ trig = "h" .. lvl, snippetType = "autosnippet" },
        { t(string.rep("#", lvl) .. " "), d(1, helper.get_visual), i(0) },
        { condition = cond.line_begin }
    )
end

---@param style string
---@return function
local style = function(style)
    local sty = { ii = "*", bb = "**", bi = "***" }
    return s({ trig = "x" .. style, snippetType = "autosnippet" },
        fmta(sty[style] .. "<>" .. sty[style], { d(1, helper.get_visual) })
    )
end

return {
    heading(1),
    heading(2),
    heading(3),
    heading(4),
    heading(5),
    heading(6),

    style("ii"),
    style("bb"),
    style("bi"),

}
