---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("LuaSnip.tex.utils.conditions")
local helper = require("LuaSnip.helper")

--[[ setup common configuration for some packages ]]
return {
    s({ trig = "setup_page_layout", dscr = "Setup default page layout" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% PAGE LAYOUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage[<><>]{geometry}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(1, "a4paper"),
                i(2, ",left=4cm,top=3cm,right=3cm,bottom=3cm"),
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_lang_font_id", dscr = "Setup default fonts" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% LANGUAGE and FONT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{indentfirst,polyglossia,fontspec}
        \setdefaultlanguage[<>]{<>}
        \setotherlanguages{<>}

        % \setmainfont{Times New Roman}
        % \setsansfont{Arial}
        % \setmonofont{}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(2, "variant=indonesian"),
                i(1, "malay"),
                i(3, "english"),
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_lang_font_zh", dscr = "Setup default fonts" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% LANGUAGE and FONT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{indentfirst,xeCJK, xpinyin}
        % \setdefaultlanguage[<>]{<>}
        % \setotherlanguages{<>}

        \setmainfont{Times New Roman}
        \setCJKmainfont{Noto Serif CJK SC}
        \setCJKsansfont{Source Han Sans CN}
        \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(2, "variant=indonesian"),
                i(1, "malay"),
                i(3, "english"),
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_par_line", dscr = "Setup paragraph and line spacing" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% PARAGRAPH and LINE SPACING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{microtype,titlesec,titling,setspace,lipsum}
        \usepackage<>{parskip}
        \onehalfspacing
        %% (reformat title and sections below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \begin{center}
        %         \large\bfseries\thetitle %large,Large,LARGE,huge,Huge,HUGE
        %     \end{center}
        %     \vspace{1em}
        % }
        % \titleformat*{\section}{\normalsize\bfseries}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            { c(1, {
                t(""),
                sn(1, { t("[indent="), i(1, "30"), t("pt]") }),
            })
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_tikz", dscr = "Setup tikz" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% TIKZ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{tikz}
        \usetikzlibrary{calc,positioning<>}
        %% (reformat/define stuff below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            { i(1, ",arrows.meta,mindmap,backgrounds"), }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_biblatex", dscr = "My common biblatex setup" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% BIBLYOGRAPHY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage[
        backend=biber,
        style=authoryear,
        hyperref=true,
        ]{biblatex}
        %% (reformat stuff below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % \renewbibmacro{in:}{} % removes in
        % \DeclareFieldFormat{pages}{#1} % removes pages
        % \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
        \addbibresource{ref.bib}<>
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            { i(0) }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    -- always load this at the end of preamble
    s({ trig = "setup_hyperref", dscr = "My common biblatex setup" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% REFERENCES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{hyperref}
        \hypersetup{<>}
        \urlstyle{same}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(1, "colorlinks=true, citecolor=blue, linkcolor=blue, urlcolor=blue"),
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "qw", name = "inline code", dscr = "inline code, ft escape" },
        fmta([[
    \mintinline{<>}<>
    ]], { i(1, "text"),
            c(2, {
                sn(nil, { t("{"), i(1), t("}") }),
                sn(nil, { t("|"), i(1), t("|") })
            }), }
        )),

}
