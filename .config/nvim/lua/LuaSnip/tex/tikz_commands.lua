---@diagnostic disable: undefined-global

local cond = require("LuaSnip.tex.utils.conditions")
local helper = require("LuaSnip.helper")

return {

    s({ trig = "dd", snippetType = "autosnippet", },
        fmta(
            [[\draw [<>]    (<>)    <>  (<>)<>; ]],
            {
                i(1, "styling"),
                i(2, "coordinate or node name"),
                i(3, "--"), -- grid
                i(4, "coordinate or node name"),
                i(0)
            }
        ),
        { condition = cond.in_tikz, show_condition = cond.in_tikz }
    ),

    -- s("trig", c(1, {
    --     t("Ugh boring, a text node"),
    --     i(nil, "At least I can edit something now..."),
    --     f(function(args) return "Still only counts as text!!" end, {})
    -- }))
}
