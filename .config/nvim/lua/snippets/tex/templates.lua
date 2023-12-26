---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

return {

    s({ trig = "t_empty", dscr = "Empty template" },
        fmta([[
        %! TeX program = lualatex

        \documentclass[a4paper,12pt]{extarticle}

        <>

        <>

        <>


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        \begin{document}
        \maketitle

        <>

        \end{document}
        ]],
            {
                c(3, {
                    t("% setup_page_layout"),
                    sn(nil, { t("setup_page_layout"), i(1) }), -- Expand end enter in insert mode so that it could suggest another snippet to expand
                }),
                c(4, {
                    t("% setup_lang_font_id"),
                    sn(nil, { t("setup_lang_font_id"), i(1) }),
                }),
                c(5, {
                    t("% setup_par_line"),
                    sn(nil, { t("setup_par_line"), i(1) }),
                }),
                i(1, "The Title"),
                i(2, "The Author"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_essay", dscr = "Essay emplate" },
        fmta([[
        %! TeX program = lualatex

        \documentclass[a4paper,12pt]{extarticle}

        <>

        <>

        <>

        <>

        <>


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                c(3, {
                    t("% setup_page_layout"),
                    sn(nil, { t("setup_page_layout"), i(1) }),
                }),
                c(4, {
                    t("% setup_lang_font_id"),
                    sn(nil, { t("setup_lang_font_id"), i(1) }),
                }),
                c(5, {
                    t("% setup_par_line"),
                    sn(nil, { t("setup_par_line"), i(1) }),
                }),
                c(6, {
                    t("% setup_biblatex"),
                    sn(nil, { t("setup_biblatex"), i(1) }),
                }),
                c(7, {
                    t("% setup_hyperref"),
                    sn(nil, { t("setup_hyperref"), i(1) }),
                }),
                i(1, "The Title"),
                i(2, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_pratial_chinese" },
        fmta([[
        %! TEX TS-program = xelatex

        \documentclass[12pt]{extarticle}

        <>

        <>

        <>

        <>

        <>


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                c(3, {
                    t("% setup_page_layout"),
                    sn(nil, { t("setup_page_layout"), i(1) }),
                }),
                c(4, {
                    t("% setup_lang_font_zh"),
                    sn(nil, { t("setup_lang_font_zh"), i(1) }),
                }),
                c(5, {
                    t("% setup_par_line"),
                    sn(nil, { t("setup_par_line"), i(1) }),
                }),
                c(6, {
                    t("% setup_biblatex"),
                    sn(nil, { t("setup_biblatex"), i(1) }),
                }),
                c(7, {
                    t("% setup_hyperref"),
                    sn(nil, { t("setup_hyperref"), i(1) }),
                }),
                i(1, "The Title"),
                i(2, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_full_chinese" },
        fmta([[
        %! TEX TS-program = xelatex

        \documentclass[12pt]{extarticle}
        \usepackage[UTF8]{ctex}

        <>

        <>

        <>

        <>

        <>


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                c(3, {
                    t("% setup_page_layout"),
                    sn(nil, { t("setup_page_layout"), i(1) }),
                }),
                c(4, {
                    t("% setup_lang_font_zh"),
                    sn(nil, { t("setup_lang_font_zh"), i(1) }),
                }),
                c(5, {
                    t("% setup_par_line"),
                    sn(nil, { t("setup_par_line"), i(1) }),
                }),
                c(6, {
                    t("% setup_biblatex"),
                    sn(nil, { t("setup_biblatex"), i(1) }),
                }),
                c(7, {
                    t("% setup_hyperref"),
                    sn(nil, { t("setup_hyperref"), i(1) }),
                }),
                i(1, "The Title"),
                i(2, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),
    -- s({ trig = "t_full_chinese" },
    --     fmta([[
    --     %! TEX TS-program = xelatex
    --
    --     \documentclass[12pt]{extarticle}
    --
    --     setup_page_layout<>
    --
    --     setup_lang_font_zh<>
    --
    --     setup_par_line<>
    --
    --     setup_biblatex<>
    --
    --     setup_hyperref<>
    --
    --
    --     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    --     \title{<>}
    --     \author{<>}
    --     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    --
    --
    --     \begin{document}
    --     \maketitle
    --
    --     <>
    --
    --     % \printbibliography
    --
    --     \end{document}
    --     ]],
    --         {
    --             i(3),
    --             i(4),
    --             i(5),
    --             i(6),
    --             i(7),
    --             i(1, "The Title"),
    --             i(2, "The Name"),
    --             i(0),
    --         }
    --     ),
    --     { condition = cond.on_first_line, show_condition = cond.on_first_line }
    -- ),
}
