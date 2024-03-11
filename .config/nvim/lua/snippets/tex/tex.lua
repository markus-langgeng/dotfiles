---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")
local packages = require("snippets.tex.templates.packages")
local preamble = require("snippets.tex.templates.preamble")
local body = require("snippets.tex.templates.body")
local doctypes = require("snippets.tex.utils.enums").Types
local engines = require("snippets.tex.utils.enums").Engines
local docclasses = require("snippets.tex.utils.enums").Classes

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

local make_preamble = function(trig, template)
    return s({ trig = trig }, fmta(template,
            {}),
        {
            condition = cond.on_first_line,
            show_condition = cond.on_first_line,
        }
    )
end

local individual_latex_pkg = function(trig, package)
    package = package or function() return "" end
    return s({ trig = trig }, fmta(package,
            {}),
        { -- for some reason, I can't use the `*` operator, instead need to use `and`
            condition = cond.line_begin and cond.in_preamble,
            show_condition = cond.line_begin and cond.in_preamble
        }
    )
end

return {

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
    s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "display name"),
            }
        )
    ),

    -- HEADINGS ----------------------------------------------------------------
    s({ trig = "ch", dscr = "Chapter", snippetType = "autosnippet" },
        fmta([[\chapter{<>} \label{ch:<>}]], { d(1, helper.get_visual), rep(1) }),
        { condition = cond.line_begin }
    ),
    s({ trig = "h1", dscr = "Level 1 section", snippetType = "autosnippet" },
        fmta([[\section{<>} \label{sec:<>}]], { d(1, helper.get_visual), rep(1) }),
        { condition = cond.line_begin }
    ),
    s({ trig = "h2", dscr = "Level 2 section", snippetType = "autosnippet" },
        fmta([[\subsection{<>} \label{ssec:<>}]], { d(1, helper.get_visual), rep(1) }),
        { condition = cond.line_begin }
    ),
    s({ trig = "h3", dscr = "Level3 section", snippetType = "autosnippet" },
        fmta([[\subsubsection{<>} \label{sssec:<>}]], { d(1, helper.get_visual), rep(1) }),
        { condition = cond.line_begin }
    ),
    ----------------------------------------------------------------------------

    s({ trig = "nn", dscr = "A generic new environmennt" },
        fmta([[
        \begin<>{<>}<>
            <>
        \end{<>}
        ]],
            {
                c(2, {
                    t(""),
                    sn(1, { t("["), i(1), t("]") }),
                    sn(1, { t("{"), i(1), t("}") }),
                }),
                i(1),
                c(3, {
                    t(""),
                    sn(1, { t("["), i(1), t("]") }),
                    sn(1, { t("{"), i(1), t("}") }),
                }),
                i(4),
                rep(1),
            }
        ),
        { condition = cond.line_begin }
    ),

    s({ trig = "ii", dscr = "The \\item command", snippetType = "autosnippet" },
        t("\\item"),
        { condition = cond.in_list_env * cond.line_begin }
    ),

    s({ trig = "cmm", dscr = "Change to latex command", snippetType = "autosnippet" },
        fmta("\\<><>{<>}",
            {
                d(2, helper.get_visual),
                c(3, {
                    t(""),
                    sn(1, { t("["), i(1), t("]") }),
                }),
                i(1),
            }
        )
    ),

    -- COMMON PREAMBLE COMMANDS ------------------------------------------------
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
        fmta("\\usepackage<>{<>}",
            {
                c(2, {
                    t(""),
                    sn(1, { t("["), i(1), t("]") }),
                }),
                i(1),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, }
    ),
    ----------------------------------------------------------------------------

    -- FONT STYLE --------------------------------------------------------------
    -- I changed this from `tii` to `xii` because my `t` key is broken
    s({ trig = "xii", dscr = "Italic", snippetType = "autosnippet" }, -- tii
        fmta("\\textit{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "xbb", dscr = "Bold", snippetType = "autosnippet" }, -- tbb
        fmta("\\textbf{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "xsl", dscr = "Slanted", snippetType = "autosnippet" }, -- tsl
        fmta("\\textsl{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "xcl", dscr = "Color", snippetType = "autosnippet" }, -- tcl
        fmta("\\textcolor{<>}{<>}",
            { i(1, "red"), d(2, helper.get_visual) }
        )
    ),
    s({ trig = "xuu", dscr = "Underline", snippetType = "autosnippet" }, -- tuu
        fmta("\\underline{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "xmm", dscr = "Emphasis", snippetType = "autosnippet" }, -- tmm
        fmta("\\emph{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "xcc", dscr = "Text cite", snippetType = "autosnippet" }, -- tcc
        fmta("\\textcite{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "pcc", dscr = "Parenthesis cite", snippetType = "autosnippet" },
        fmta("\\parencite{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "sbs", dscr = "Subscript", snippetType = "autosnippet" },
        fmta("\\textsubscript{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    s({ trig = "sps", dscr = "Superscript", snippetType = "autosnippet" },
        fmta("\\textsuperscript{<>}",
            { d(1, helper.get_visual), }
        )
    ),
    ----------------------------------------------------------------------------

    -- XPINYIN -----------------------------------------------------------------
    s({ trig = "pyy", dscr = "Use \\pinyin command", snippetType = "autosnippet" },
        fmta("\\pinyin{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.has_xpinyin * cond.in_document }
    ),

    s({ trig = "xyy", dscr = "Use \\xpinyin command", snippetType = "autosnippet" },
        fmta("\\xpinyin*{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.has_xpinyin * cond.in_document }
    ),

    s({ trig = "syy", dscr = "Pinyin scope", snippetType = "autosnippet" },
        fmta([[
        \begin{pinyinscope}
            <>
        \end{pinyinscope}
        ]],
            { i(1), }
        ),
        { condition = cond.line_begin * cond.in_document * cond.has_xpinyin }
    ),
    ----------------------------------------------------------------------------

    -- BIBLIOGRAPHY -------------------------------------------------------------
    s({ trig = "pbb", dscr = "Default option for print bibliography", snippetType = "autosnippet" },
        fmta("\\printbibliography[title=<>]",
            { i(1, "Daftar Pustaka"), }
        ),
        { condition = cond.in_document * cond.has_biblatex }
    ),
    ----------------------------------------------------------------------------

    -- LATEX PREAMBLES----------------------------------------------------------
    make_preamble("p_basic",
        preamble.build_preamble_template(doctypes.biasa, engines.lualatex, docclasses.article, false)),
    make_preamble("p_tugas",
        preamble.build_preamble_template(doctypes.tugas, engines.lualatex, docclasses.article, false)),
    make_preamble("p_tugas_cina",
        preamble.build_preamble_template(doctypes.tugas, engines.xelatex, docclasses.article, true)),
    make_preamble("p_makalah",
        preamble.build_preamble_template(doctypes.makalah, engines.lualatex,
            docclasses.report, false)),
    make_preamble("p_makalah_cina",
        preamble.build_preamble_template(doctypes.makalah, engines.xelatex,
            docclasses.report, true)),
    ----------------------------------------------------------------------------

    -- LATEX BODY --------------------------------------------------------------
    s({ trig = "titlepage" }, fmta(body.titlepage(), {}),
        {
            condition = cond.line_begin and cond.in_document,
            show_condition = cond.line_begin and cond.in_document,
        }),
    ----------------------------------------------------------------------------


    -- LATEX PACKAGES ----------------------------------------------------------
    individual_latex_pkg("pagelayout", packages.page_layout_group.build()),
    individual_latex_pkg("langfont", packages.language_and_font_group.build()),
    individual_latex_pkg("langfont_cn", packages.language_and_font_chinese_group.build()),
    individual_latex_pkg("parline", packages.paragraph_and_line_group.build()),
    individual_latex_pkg("parline_makalah", packages.paragraph_and_line_group.build(doctypes.makalah.name)),
    individual_latex_pkg("bibliography", packages.bibliography_group.build()),
    individual_latex_pkg("add_images", packages.images_group.build()),
    individual_latex_pkg("references", packages.references_group.build()),
    ----------------------------------------------------------------------------


    -- FONTSPEC ----------------------------------------------------------------
    s({ trig = "xrm", dscr = "text roman (serif)", snippetType = "autosnippet" },
        fmta("\\textrm{<>}",
            { d(1, helper.get_visual) }
        ),
        { condition = cond.in_document * cond.has_fontspec }
    ),
    s({ trig = "xsn", dscr = "text sans serif font", snippetType = "autosnippet" },
        fmta("\\textsf{<>}",
            { d(1, helper.get_visual) }
        ),
        { condition = cond.in_document * cond.has_fontspec }
    ),
    s({ trig = "xmn", dscr = "text mono font", snippetType = "autosnippet" },
        fmta("\\texttt{<>}",
            { d(1, helper.get_visual) }
        ),
        { condition = cond.in_document * cond.has_fontspec }
    ),
    ----------------------------------------------------------------------------

    -- MATH RELATED ------------------------------------------------------------
    s({ trig = "sqq", dscr = "Square root", snippetType = "autosnippet", },
        fmta(
            "\\sqrt{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.in_mathzone }
    ),

    s({ trig = "rm", dscr = "Remove math formatting (upright-text)", snippetType = "autosnippet" },
        fmta(
            "\\mathrm{<>}",
            { d(1, helper.get_visual), }
        ),
        { condition = cond.in_mathzone }
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

    s({ trig = "([^%a])mm", dscr = "Inline math (expand with <C-s>)", wordTrig = false, regTrig = true, },
        fmta(
            "<>$<>$",
            { -- preserve the space before the 'mm' trigger
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual),
            }
        )
    ),
    s({ trig = "([^%a])MM", dscr = "Display math (expand with <C-s>)", wordTrig = false, regTrig = true, },
        fmta(
            "<>\\[ <> \\]",
            { -- preserve the space before the 'mm' trigger
                f(function(_, snip) return snip.captures[1] end),
                d(1, helper.get_visual),
            }
        )
    ),
    ----------------------------------------------------------------------------



}
