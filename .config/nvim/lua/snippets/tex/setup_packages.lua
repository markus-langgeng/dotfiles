---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

local M = {}

M.separator = string.rep("%", 80)
M.section_title = function(title)
    title = title or ""
    return string.format("%s %s %s", string.rep("%", 2), title, string.rep("%", 80 - (title):len() - 4))
end

M.pagelayout = function(papersize, left, top, right, bottom)
    local title = M.section_title("PAGELAYOUT")
    local res = string.format([[
    %s
    \usepackage[%s,left=%s,top=%s,right=%s,bottom=%s,]{geometry}
    %s
    ]], title, papersize, left, top, right, bottom, M.separator)
    return res
end

M.langfont = function(mainlang, fonts)
    local title = M.section_title("LANGUAGE & FONTS")

    if mainlang == "id" then
        mainlang = "\\setdefaultlanguage[variant=indonesian]{malay}"
    else
        mainlang = "\\setdefaultlanguage{english}"
    end

    if fonts == "ms" then
        fonts = [[\setmainfont{Times New Roman} % Liberation Serif
    \setsansfont{Arial} % Liberation Sans
    \setmonofont{Courier New} % Liberation Mono]]
    else
        fonts = [[\setmainfont{Liberation Serif} % Times New Roman
    \setsansfont{Liberation Sans} % Arial
    \setmonofont{Liberation Mono}]]
    end

    local res = string.format([[
    %s
    \usepackage{polyglossia,fontspec}
    %s
    %s
    %s
    ]], title, mainlang, fonts, M.separator)

    return res
end

M.langfont_cn = function()
    local title = M.section_title("CHINESE LANGUAGE & FONTS")
    local fonts = [[\setCJKmainfont{Noto Serif CJK SC}
    \setCJKsansfont{Noto Sans CJK SC}
    \setCJKmonofont{Noto Sans Mono CJK SC}]]

    local res = string.format([[
    %s
    \usepackage{xeCJK,xpinyin}
    %s
    %s
    ]], title, fonts, M.separator)

    return res
end

M.parline = function(type)
    -- TODO: buat kondisi utk makalah (perlu format chapter, section, toc)
    local title = M.section_title("PARAGRAPH & LINES")
    local reformat_sections

    if type == "makalah" then

        reformat_sections = [[\renewcommand{\thechapter}{\Roman{chapter}}
    \renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}

    \titleformat{\chapter}[display] %% shape
    {\bfseries\normalsize\center} %% format
    {\MakeUppercase\chaptertitlename \ \thechapter} %% label
    {-1.2em} %% sep
    {\MakeUppercase} %% before-code [] %% aftercode

    \titleformat{\section}
    {\bfseries\normalsize}
    {\thesection\quad}
    {0em}
    {}

    \titleformat{\subsection}
    {\bfseries\normalsize}
    {\thesubsection\quad}
    {0em}
    {}

    \titlespacing{\chapter}{0em}{-3em}{1em}

    \titlecontents{chapter} %% omit backslash
    [0em]
    {\vspace{1em}} %% above-code
    {\bfseries\MakeUppercase\chaptertitlename \ \thecontentslabel\quad\uppercase} %% numbered-entry-format
    {\bfseries\uppercase} %% numberedless-entry-format
    {\ \titlerule*[.75em]{.}\contentspage} %% filler-page-format]]

    else

        reformat_sections = [[\renewcommand{\maketitle}{ %% change layout for title and author
    %% tiny,scriptsize,footnotesize,small,normalsize,large,Large,LARGE,huge,Huge,HUGE
    \noindent\normalsize\theauthor
    \begin{center}
        \large\bfseries\thetitle
    \end{center}
    \vspace{1em}
    }]]

    end

    local res = string.format([[
    %s
    \usepackage{microtype,setspace,indentfirst}
    \usepackage{titlesec,titling,titletoc}
    \usepackage[indent=30pt,skip=15pt]{parskip}
    \onehalfspacing

    %s
    %s
    ]], title, reformat_sections, M.separator)

    return res
end

-- use this as last package
M.references = function()
    local title = M.section_title("HYPERREF")
    local res = string.format([[
    %s
    \usepackage{hyperref}
    \hypersetup{colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue}
    \urlstyle{same}
    %s
    ]], title, M.separator)
    return res
end

M.bibliography = function()
    local title = M.section_title("BIBLIOGRAPHY")
    local res = string.format([[
    %s
    \usepackage[
    backend=biber,
    style=authoryear,
    hyperref=true,
    ]{biblatex}

    \addbibresource{ref.bib}
    %% \DeclareFieldFormat{url}{\url{#1}}
    %% \renewbibmacro{in:}{} %% removes in
    %% \DeclareFieldFormat{pages}{#1} %% removes pages
    %% \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
    %s
    ]], title, M.separator)
    return res
end

return M

--     s({ trig = "s_img", dscr = "Setup default settings to import images" },
--         fmta([[
--         <sect_separator>
--         <sect_title>
--         \usepackage{graphicx}
--         \graphicspath{{<path>/}}
--         <sect_separator>
--         ]],
--             {
--                 sect_separator = t(string.rep("%", 80)),
--                 sect_title = f(make_section_title, {}, { user_args = { "Paragraph and Line Spacing" } }),
--                 path = i(1, "img"),
--             }
--         ),
--         { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
--     ),

--     --------------------------------
--
--     s({ trig = "setup_tikz", dscr = "Setup tikz" },
--         fmta([[
--
--         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--         %% TIKZ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--         % \usepackage{eso-pic} % load before tikz
--         \usepackage{tikz}
--         \usetikzlibrary{calc,positioning<>}
--         %% (reformat/define stuff below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--
--         ]],
--             { i(1, ",arrows.meta,mindmap,backgrounds"), }
--         ),
--         { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
--     ),
--
--     s({ trig = "setup_tabularx", dscr = "Setup for tabularx" },
--         fmta([[
--
--         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--         %% TABULARX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--         \usepackage{array,tabularx}
--         % \renewcommand{\arraystretch}{<>} % add padding on top of cell
--         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--
--         ]],
--             {
--                 i(1, "1.5")
--             }
--         ),
--         { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
--     ),
--
--     s({ trig = "setup_bg_img", dscr = "Setup background image. Need to load eso-pic package before tikz" },
--         fmta([[
--         \AddToShipoutPictureBG{
--             \begin{tikzpicture}[remember picture, overlay]
--                 \node[opacity=.25,inner sep=0pt]
--                     at (current page.center){
--                     \includegraphics[width=<>,<>]{<>}};
--             \end{tikzpicture}
--         }
--         ]],
--             {
--                 i(2, "\\paperwidth"),
--                 i(3, "height=\\paperheight"),
--                 i(1, "image_name"),
--             }
--         ),
--         { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
--     ),
--
-- }
