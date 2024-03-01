---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

return {

    s({ trig = "dd", snippetType = "autosnippet", },
        fmta(
            [[\draw [<styling>]    (<coor_nodename>)    <>  (<coor2_nodename2>)<>;]],
            {
                styling = i(1, "styling"),
                coor_nodename = i(2, "0,0"), -- first coordinate or node name
                i(3, "--"),  -- grid
                coor2_nodename2 = i(4, "2,2"), -- second coordinate or node name
                i(0)
            }
        ),
        { condition = cond.in_tikz * cond.line_begin, show_condition = cond.in_tikz }
    ),

    s({ trig = "ff", snippetType = "autosnippet", },
        fmta(
            [[\fill [<>]    (<>)    <>  (<>);]],
            {
                i(1, "green!20!pink"),                      -- mix green and purple
                i(2, "0,0"),                                -- first coordinate or node name
                i(3, "rectangle"),                          -- shape
                i(4, [[\the\paperwidth,\the\paperheight]]), -- second coordinate or node name
            }
        ),
        { condition = cond.in_tikz * cond.line_begin, show_condition = cond.in_tikz }
    ),

    s({ trig = "nd", snippetType = "autosnippet", },
        fmta(
            [[
            \node (<>) [<>] <> {<>};
            ]],
            {
                i(1, "node_name"),
                i(2, "node_style"),
                c(3, {
                    sn(nil, { t("at ("), i(1, "current page.center"), t(")") }),
                    sn(nil, { t("[below=of "), i(1, "node_name"), t("]") }),
                }),
                i(4, "node content (text or image)"),
            }
        ),
        { condition = cond.in_tikz * cond.line_begin, show_condition = cond.in_tikz }
    ),

    s({ trig = "zpp", snippetType = "autosnippet", },
        fmta(
            [[
            \begin{tikzpicture}[
                <>/.style={
                    opacity=.5,
                    rectangle,
                    inner sep=0pt,
                    minimum size=4mm,
                    anchor=center,
                    %draw=blue!50,
                    %fill=blue!50,
                    %thick,
                },
                ]

            <>

            \end{tikzpicture}
            ]],
            {
                i(1, "node_style1"),
                i(0)
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_tikz }
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
