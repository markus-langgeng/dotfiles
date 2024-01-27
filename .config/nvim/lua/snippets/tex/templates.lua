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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title{<>}
        \author{<>}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


    s({ trig = "b_empty" },
        fmta([[
        %! TEX TS-program = xelatex

        \documentclass[14pt]{beamer}
        % \usetheme{}
        % \usefonttheme{}
        % \usecolortheme{}

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \title[<>]{<>}
        \subtitle{<>}
        \author[<>]{<>}
        \institute[<>]{<>}
        \date[<>]{<>}

        % \logo{\includegraphics...}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        \begin{document}
        \frame{\titlepage}

        <>

        \end{document}
        ]],
            {
                i(2, "Short Title"),
                i(1, "Awesome Full-length Title"),
                i(4, "Langgeng, Nggenglang"),
                i(3, "M.~Langgeng\\inst{1} \\and M.~Nggenglang\\inst{2}"),
                i(5, "Nice Subtitle"),
                i(7, "UB"),
                i(6, "\\inst{1} Fakultas Ilmu Budaya\\\\Universitas Brawijaya \\and \\inst{2} Fakultas Ilmu Budaya\\\\Universitas Brawijaya"),
                i(9, "KB 2024"),
                i(8, "Konferensi Besar, April 2024"),
                i(0, ""),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),
}

