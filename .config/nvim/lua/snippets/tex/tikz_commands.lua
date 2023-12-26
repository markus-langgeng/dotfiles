---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

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
        { condition = cond.in_tikz * cond.line_begin, show_condition = cond.in_tikz }
    ),

    s({ trig = "nd", snippetType = "autosnippet", },
        fmta(
            [[\node [<>]    [<>]    {<>}; ]],
            {
                i(1, "name of node"),
                i(2, "styling or name of tikzstyle, position"),
                i(3, "the content"),
            }
        ),
        { condition = cond.in_tikz * cond.line_begin, show_condition = cond.in_tikz }
    ),

    s({ trig = "zss", snippetType = "autosnippet", },
        fmta(
            [[
            \tikzstyle{<>}=[
            <>
            ]
            ]],
            {
                i(1, "name of tikzstyle"),
                i(2, "options"),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_tikz }
    ),
    -- s("trig", c(1, {
    --     t("Ugh boring, a text node"),
    --     i(nil, "At least I can edit something now..."),
    --     f(function(args) return "Still only counts as text!!" end, {})
    -- }))
}
