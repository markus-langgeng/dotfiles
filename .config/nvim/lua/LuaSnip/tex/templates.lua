---@diagnostic disable: undefined-global

local cond = require("LuaSnip.tex.utils.conditions")
local helper = require("LuaSnip.helper")

return {

    s({ trig = "t_empty", dscr = "Empty template" },
        fmta([[
        %! TeX program = lualatex

        \documentclass{article}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{fontspec, polyglossia}
        \setdefaultlanguage{english}
        % \setotherlanguages{indonesian, chinese}

        % \setmainfont{Times New Roman}
        % \setsansfont{Arial}
        % \setmonofont{}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype, lipsum}
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        %-----------------------------------------------------------------------


        % REFERENCES -----------------------------------------------------------
        \usepackage{hyperref} % always set at the end
        \hypersetup{
            colorlinks=true,
            citecolor=blue,
            linkcolor=blue,
            urlcolor=blue,
        }
        %-----------------------------------------------------------------------


        %-----------------------------------------------------------------------
        \title{<>}
        \author{<>}
        %-----------------------------------------------------------------------


        \begin{document}
        \maketitle

        <>

        \end{document}
        ]],
            {
                i(1, "a4paper"),
                i(2, "The Title"),
                i(3, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_essay", dscr = "Essay emplate" },
        fmta([[
        %! TeX program = lualatex

        \documentclass{article}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{fontspec, polyglossia}
        \setdefaultlanguage[variant=indonesian]{malay}
        \setotherlanguages{english}
        % \setotherlanguages{indonesian, chinese}

        % \setmainfont{Times New Roman}
        % \setsansfont{Arial}
        % \setmonofont{}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype, lipsum}
        \usepackage{titlesec}
        \usepackage{titling}
        \usepackage{parskip, setspace}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \setlength{\droptitle}{-20mm}
        % \renewcommand{\maketitle}{
        %     \normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \normalsize\bfseries\thetitle
        %     \end{center}
        %     \vspace{1.5em}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear-ibid
        ]{biblatex}
        \addbibresource{ref.bib}
        %-----------------------------------------------------------------------


        % REFERENCES -----------------------------------------------------------
        \usepackage{hyperref} % always set at the end
        \hypersetup{
            % colorlinks=true,
            % citecolor=blue,
            % linkcolor=blue,
            % urlcolor=blue,
        }
        %-----------------------------------------------------------------------


        %-----------------------------------------------------------------------
        \title{<>}
        \author{<>}
        %-----------------------------------------------------------------------


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                i(1, "a4paper"),
                i(2, "The Title"),
                i(3, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_pratial_chinese" },
        fmta([[
        %! TEX TS-program = xelatex

        \documentclass{article}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{xeCJK, xpinyin}
        \setCJKmainfont{Noto Serif CJK SC}
        % \setCJKmainfont{Source Han Sans CN}
        \xpinyinsetup{ratio={.8}, hsep={.5em}, vsep={1.2em}}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype, lipsum}
        % \usepackage{titlesec}
        % \usepackage{titling}
        % \usepackage{parskip, setspace}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \setlength{\droptitle}{-20mm}
        % \renewcommand{\maketitle}{
        %     \normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \normalsize\bfseries\thetitle
        %     \end{center}
        %     \vspace{1.5em}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear,
        citestyle=numeric,
        sorting=ynt,
        hyperref=true,
        ]{biblatex}
        \addbibresource{ref.bib}
        %-----------------------------------------------------------------------


        % REFERENCES -----------------------------------------------------------
        \usepackage{hyperref} % always set at the end
        \hypersetup{
            colorlinks=true,
            citecolor=blue,
            linkcolor=blue,
            urlcolor=blue,
        }
        %-----------------------------------------------------------------------


        %-----------------------------------------------------------------------
        \title{<>}
        \author{<>}
        %-----------------------------------------------------------------------


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                i(1, "a4paper"),
                i(2, "The Title"),
                i(3, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),

    s({ trig = "t_full_chinese" },
        fmta([[
        %! TEX TS-program = xelatex

        \documentclass{article}
        \usepackage[fontest=none]{ctex}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{xpinyin}
        \setCJKmainfont{Noto Serif CJK SC}
        \setCJKsansfont{Source Han Sans CN}
        \xpinyinsetup{ratio={.8}, hsep={.5em}, vsep={1.2em}}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype, lipsum}
        % \usepackage{titlesec}
        % \usepackage{titling}
        % \usepackage{parskip, setspace}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \setlength{\droptitle}{-20mm}
        % \renewcommand{\maketitle}{
        %     \normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \normalsize\bfseries\thetitle
        %     \end{center}
        %     \vspace{1.5em}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear,
        citestyle=numeric,
        sorting=ynt,
        hyperref=true,
        ]{biblatex}
        \addbibresource{ref.bib}
        %-----------------------------------------------------------------------


        % REFERENCES -----------------------------------------------------------
        \usepackage{hyperref} % always set at the end
        \hypersetup{
            colorlinks=true,
            citecolor=blue,
            linkcolor=blue,
            urlcolor=blue,
        }
        %-----------------------------------------------------------------------


        %-----------------------------------------------------------------------
        \title{<>}
        \author{<>}
        %-----------------------------------------------------------------------


        \begin{document}
        \maketitle

        <>

        % \printbibliography

        \end{document}
        ]],
            {
                i(1, "a4paper"),
                i(2, "The Title"),
                i(3, "The Name"),
                i(0),
            }
        ),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    ),
}
