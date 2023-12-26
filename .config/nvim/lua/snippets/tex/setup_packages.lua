---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

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
                i(1, "a4paper,"),
                i(2, "left=4cm,top=3cm,right=3cm,bottom=3cm,showframe"),
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
        \usepackage{indentfirst,xeCJK,xpinyin}
        % \setdefaultlanguage[]{}
        % \setotherlanguages{}

        % \setmainfont{Times New Roman}
        \setCJKmainfont{<>}
        \setCJKsansfont{<>} % Source Han Sans CN, BabelStone Han
        \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(1, "Noto Serif CJK SC"),
                i(2, "Source Han Sans CN"),
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
        % \usepackage{eso-pic} % load before tikz
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

    s({ trig = "setup_include_img", dscr = "Setup to include image" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% INCLUDE IMAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{graphicx}
        \graphicspath{{<>/}}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(1, "img")
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_tabularx", dscr = "Setup for tabularx" },
        fmta([[

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% TABULARX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \usepackage{array,tabularx}
        % \renewcommand{\arraystretch}{<>} % add padding on top of cell
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ]],
            {
                i(1, "1.5")
            }
        ),
        {
            condition = cond.in_preamble * cond.line_begin,
            show_condition = cond.in_preamble,
        }
    ),

    s({ trig = "setup_bg_img", dscr = "Setup background image. Need to load eso-pic package before tikz" },
        fmta([[
        \AddToShipoutPictureBG{
            \begin{tikzpicture}[remember picture, overlay]
                \node[opacity=.25,inner sep=0pt]
                    at (current page.center){
                    \includegraphics[width=<>,<>]{<>}};
            \end{tikzpicture}
        }
        ]],
            {
                i(2, "\\paperwidth"),
                i(3, "height=\\paperheight"),
                i(1, "image_name"),
            }
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

    -- s({ trig = "qw", name = "inline code", dscr = "inline code, ft escape" },
    --     fmta([[
    --     \mintinline{<>}<>
    --     ]],
    --         {
    --             i(1, "text"),
    --             c(2, {
    --                 sn(nil, { t("{"), i(1), t("}") }),
    --                 sn(nil, { t("|"), i(1), t("|") })
    --             }),
    --         }
    --     ), {}),


}
