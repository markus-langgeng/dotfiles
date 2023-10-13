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
        \usepackage{fontspec}
        \usepackage{polyglossia}
        \setdefaultlanguage[variant=indonesian]{malay}
        \setotherlanguages{english}

        % \setmainfont{Times New Roman}
        % \setsansfont{Arial}
        % \setmonofont{}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype,lipsum,titlesec,titling}
        \usepackage[indent=30pt]{parskip}
        \usepackage{setspace}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \large\bfseries\thetitle
        %     \end{center}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        %-----------------------------------------------------------------------


        % REFERENCES -----------------------------------------------------------
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

        \documentclass[12pt]{extarticle}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{fontspec}
        \usepackage{polyglossia}
        \setdefaultlanguage[variant=indonesian]{malay}
        \setotherlanguages{english}
        % \setotherlanguages{indonesian, chinese}

        % \setmainfont{Times New Roman}
        % \setsansfont{Arial}
        % \setmonofont{}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype,titlesec,titling,setspace,lipsum}
        \usepackage[indent=30pt]{parskip}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \large\bfseries\thetitle
        %     \end{center}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear,
        % citectyel=apa,
        % hyperref=true,
        ]{biblatex}
        % \renewbibmacro{in:}{} % removes in
        % \DeclareFieldFormat{pages}{#1} % removes pages
        % \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
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

        \documentclass[12pt]{extarticle}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{xeCJK, xpinyin}
        \setmainfont{Times New Roman}
        \setCJKmainfont{Noto Serif CJK SC}
        \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype,titlesec,titling,setspace,lipsum}
        \usepackage[indent=30pt]{parskip}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \large\bfseries\thetitle
        %     \end{center}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear-ibid,
        citestyle=apa,
        % hyperref=true,
        ]{biblatex}
        % \renewbibmacro{in:}{} % removes in
        % \DeclareFieldFormat{pages}{#1} % removes pages
        % \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
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

        \documentclass[12pt]{extarticle}

        \usepackage[<>]{geometry}


        % LANGUAGE & FONT ------------------------------------------------------
        \usepackage{xeCJK, xpinyin}
        \setmainfont{Times New Roman}
        \setCJKmainfont{Noto Serif CJK SC}
        \setCJKsansfont{Source Han Sans CN}
        \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
        %-----------------------------------------------------------------------


        % PARAGRAPH & LINE SPACING & FORMATTING---------------------------------
        \usepackage{microtype,titlesec,titling,setspace,lipsum}
        \usepackage[indent=30pt]{parskip}
        % \onehalfspacing
        % \titleformat*{\section}{\normalsize\bfseries}
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \vspace{1em}
        %     \begin{center}
        %         \large\bfseries\thetitle
        %     \end{center}
        % }
        %-----------------------------------------------------------------------


        % BIBLYOGRAPHY ---------------------------------------------------------
        \usepackage[
        backend=biber,
        bibstyle=authoryear-ibid,
        citestyle=apa,
        % hyperref=true,
        ]{biblatex}
        % \renewbibmacro{in:}{} % removes in
        % \DeclareFieldFormat{pages}{#1} % removes pages
        % \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
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
