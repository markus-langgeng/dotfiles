---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("LuaSnip.tex.utils.conditions")
local helper = require("LuaSnip.helper")

local make_gletters = function(trig, letter, command)
    return s({ trig = trig, dscr = "Greek letter " .. letter, snippetType = "autosnippet" },
        t(command), { condition = cond.in_mathzone, })
end

local make_pinyin_tones = function(trig, dscr, command)
    return s(
        {
            trig = "([%a%d])" .. trig,
            dscr = dscr .. " tone",
            regTrig = true,
            wordTrig = false,
            snippetType = "autosnippet",
        },
        fmta("<>\\" .. command .. "{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual),
            }
        ))
end

return {

    s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "display name"),
            }
        )
    ),

    -- headings
    s({ trig = "h1", dscr = "Level 1 heading", snippetType = "autosnippet" },
        fmta([[\section{<>}]], { i(1, "") }),
        { condition = cond.line_begin }
    ),
    s({ trig = "h2", dscr = "Level 2 heading", snippetType = "autosnippet" },
        fmta([[\subsection{<>}]], { i(1, "") }),
        { condition = cond.line_begin }
    ),
    s({ trig = "h3", dscr = "Level3 heading", snippetType = "autosnippet" },
        fmta([[\subsubsection{<>}]], { i(1, "") }),
        { condition = cond.line_begin }
    ),

    s({ trig = "nn", dscr = "A generic new environmennt" },
        fmta([[
        \begin{<>}
            <>
        \end{<>}
        ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        ),
        { condition = cond.line_begin }
    ),

    s({ trig = "it", dscr = "The \\item command", snippetType = "autosnippet" },
        t("\\item"),
        { condition = cond.in_list_env * cond.line_begin }
    ),

    --[[ PREAMBLE ]]
    s({ trig = "custom-ol", dscr = "Customize the level of ordered list" },
        fmta([[
        % set custom ol
        \renewcommand{\labelenumii}{\arabic{enumi}.\arabic{enumii}}
        \renewcommand{\labelenumiii}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}}
        \renewcommand{\labelenumiv}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}.\arabic{enumiv}}<>
        ]],
            { i(0) }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "pkg", dscr = "\\usepackage{} command", snippetType = "autosnippet" },
        fmta("\\usepackage{<>}",
            { i(0) }
        ),
        { condition = cond.in_preamble * cond.line_begin, }
    ),

    s({ trig = "font-chinese", dscr = "Add chinese font support" },
        fmta([[
        \usepackage{xeCJK, xpinyin}
        \setCJKmainfont{Noto Serif CJK SC}<>
        ]],
            { i(0) }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),
    --[[ PREAMBLE END ]]


    s({ trig = "tii", dscr = "Italic", snippetType = "autosnippet" },
        fmta("\\textit{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "tbb", dscr = "Bold", snippetType = "autosnippet" },
        fmta("\\textbf{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "tuu", dscr = "Underline", snippetType = "autosnippet" },
        fmta("\\underline{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "tmm", dscr = "Emphasis", snippetType = "autosnippet" },
        fmta("\\emph{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "tcc", dscr = "Text cite", snippetType = "autosnippet" },
        fmta("\\textcite{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "pcc", dscr = "Parenthesis cite", snippetType = "autosnippet" },
        fmta("\\parencite{<>}",
            { d(1, helper.get_visual), }
        )
    ),

    s({ trig = "pyy", dscr = "Use \\pinyin command", snippetType = "autosnippet" },
        fmta("\\pinyin{<>}",
            { d(1, helper.get_visual), }
        )
    ),

    s({ trig = "xyy", dscr = "Use \\xpinyin command", snippetType = "autosnippet" },
        fmta("\\xpinyin*{<>}",
            { d(1, helper.get_visual), }
        )
    ),

    s({ trig = "syy", dscr = "Pinyin scope", snippetType = "autosnippet" },
        fmta([[
        \begin{pinyinscope}
            <>
        \end{pinyinscope}
        ]],
            { i(1), }
        ),
        { condition = cond.line_begin }
    -- { condition = cond.has_xpinyin }
    ),


    make_pinyin_tones("-tt", "First", "="),
    make_pinyin_tones("/tt", "Second", "'"),
    make_pinyin_tones("vtt", "Third", "v"),
    make_pinyin_tones("\\tt", "Fourth", "`"),

    make_gletters(";a", "alpha", "\\alpha"),
    make_gletters(";b", "beta", "\\beta"),
    make_gletters(";g", "gamma", "\\gamma"),
    make_gletters(";d", "delta", "\\delta"),
    make_gletters(";z", "zeta", "\\zeta"),
    make_gletters(";e", "epsilon", "\\varepsilon"),
    make_gletters(";i", "iota", "\\iota"),
    make_gletters(";k", "kappa", "\\kappa"),
    make_gletters(";l", "lambda", "\\lambda"),
    make_gletters(";m", "mu", "\\mu"),
    make_gletters(";n", "nu", "\\nu"),
    make_gletters(";x", "xi", "\\xi"),
    make_gletters(";o", "o", "\\o"),
    make_gletters(";p", "pi", "\\pi"),
    make_gletters(";r", "rho", "\\rho"),
    make_gletters(";t", "tau", "\\tau"),
    make_gletters(";u", "upsilon", "\\upsilon"),
    make_gletters(";c", "chi", "\\chi"),

    --[[ MATH RELATED ]]
    s({ trig = "sqq", dscr = "Square root", snippetType = "autosnippet", },
        fmta(
            "\\sqrt{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.in_mathzone, }
    ),

    s({ trig = "rm", dscr = "Remove math formatting (upright-text)", snippetType = "autosnippet" },
        fmta(
            "\\mathrm{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.in_mathzone, }
    ),

    s({ trig = "([%a%d])^^", dscr = "Superscript", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "<>^{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual)
            }
        ), { condition = cond.in_mathzone }
    ),

    s({ trig = "([%a%d])__", dscr = "Subscript", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "<>_{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual)
            }
        ), { condition = cond.in_mathzone }
    ),

    s({ trig = "([^%a])ii", dscr = "Integral", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta(
            "<>\\int_{<>}^{<>} <> \\,dx",
            {
                f(function(_, snip) return snip.captures[1] end),
                i(2, "-\\infty"),
                i(3, "\\infty"),
                d(1, helper.get_visual),
            }
        ), { condition = cond.in_mathzone, }
    ),

    s({ trig = "([^%a])ss", dscr = "Sum", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta(
            "<>\\sum_{<>}^{<>} <>",
            {
                f(function(_, snip) return snip.captures[1] end),
                i(2, "n=1"),
                i(3, "\\infty"),
                d(1, helper.get_visual)
            }
        ), { condition = cond.in_mathzone, }
    ),

    s({ trig = "([^%a])ll", dscr = "Limit", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta(
            "<>\\lim_{<>\\to<>} <>",
            {
                f(function(_, snip) return snip.captures[1] end),
                i(2, "x"),
                i(3, "\\infty"),
                d(1, helper.get_visual)
            }
        ), { condition = cond.in_mathzone, }
    ),

    -- Type the trigger and then type <C-s> or whatever the key to jump to the next node
    s({ trig = "([^%a])ee", regTrig = true, wordTrig = false },
        fmta(
            "<>e^{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual)
            }
        ),
        { condition = cond.in_mathzone, show_condition = cond.in_mathzone }
    ),

    s({ trig = "ff", dscr = "Fraction", snippetType = "autosnippet" },
        fmta(
            "\\frac{<>}{<>}",
            { i(1), i(2), }
        ),
        { condition = cond.in_mathzone }
    ),

    s({ trig = "([^%a])mm", dscr = "Inline math", wordTrig = false, regTrig = true, },
        fmta(
            "<>$<>$",
            { -- preserve the space before the 'mm' trigger
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual),
            }
        )
    ),
    s({ trig = "([^%a])MM", dscr = "Display math", wordTrig = false, regTrig = true, },
        fmta(
            "<>\\[ <> \\]",
            { -- preserve the space before the 'mm' trigger
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual),
            }
        )
    ),
    --[[ MATH END ]]


    --[[ TIKZ ENV ]]
    s({ trig = "dd" },
        fmta(
            "\\draw [<>] ",
            {
                i(1, "params"),
            }
        ),
        { condition = cond.in_tikz, show_condition = cond.in_tikz }
    ),
    --[[ TIKZ END ]]


}
