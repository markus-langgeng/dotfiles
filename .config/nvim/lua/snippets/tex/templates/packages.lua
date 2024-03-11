---@diagnostic disable: undefined-global

-- local cond = require("snippets.tex.utils.conditions")
-- local helper = require("snippets.helper")
-- local doctype = require("snippets.tex.utils.enums").Types
local separator = string.rep("%", 80)

local M = {
    page_layout_group = { title = "Page Layout" },
    language_and_font_group = { title = "Language and Font Group" },
    language_and_font_chinese_group = { title = "language and Font Chinese Group" },
    paragraph_and_line_group = { title = "Paragraph and Line Group" },
    bibliography_group = { title = "Bibliography Group" },
    images_group = { title = "Images Group" },
    references_group = { title = "References Group" },
}

for k, v in pairs(M) do
    M[k]["custom"] = {}
end

local make_comment_banner = function(title, packages_setup)
    local title_banner = string.format(
        "%s %s %s",
        string.rep("%", 2),
        string.upper(title),
        string.rep("%", 80 - (title):len() - 4))
    local res = string.format([[
    %s
    %s
    %s]], title_banner, packages_setup, separator)
    return res
end

M.page_layout_group.build = function(papersize, left, top, right, bottom)
    papersize = papersize or "a4paper"
    left = left or "3cm"
    top = top or left or "3cm"
    right = right or top
    bottom = bottom or top
    local res = string.format([[\usepackage[%s,left=%s,top=%s,right=%s,bottom=%s,]{geometry}]],
        papersize, left, top, right, bottom)
    res = make_comment_banner(M.page_layout_group.title, res)
    return res
end

M.language_and_font_group.build = function(mainlang, fonts)
    mainlang = mainlang or "id"
    fonts = fonts or "liberation"
    local language = M.language_and_font_group.custom.main_language[mainlang]
    local fontset = M.language_and_font_group.custom.fontset[fonts]
    local res = string.format([[\usepackage{polyglossia,fontspec}
    %s
    %s]], language, fontset)
    res = make_comment_banner(M.language_and_font_group.title, res)
    return res
end

M.language_and_font_group.custom.main_language = {
    id = "\\setdefaultlanguage[variant=indonesian]{malay}",
    en = "\\setdefaultlanguage{english}"
}

M.language_and_font_group.custom.fontset = {

    ms = [[\setmainfont{Times New Roman} % Liberation Serif
    \setsansfont{Arial} % Liberation Sans
    \setmonofont{Courier New} % Liberation Mono]],

    liberation = [[\setmainfont{Liberation Serif} % Times New Roman
    \setsansfont{Liberation Sans} % Arial
    \setmonofont{Liberation Mono} % Courier New]],

}

M.language_and_font_chinese_group.build = function(fonts)
    fonts = fonts or "noto"
    local fontset = M.language_and_font_chinese_group.custom.fontset[fonts]
    local res = string.format([[\usepackage{xeCJK,xpinyin}
    \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
    %s]], fontset)
    res = make_comment_banner(M.language_and_font_chinese_group.title, res)
    return res
end

M.language_and_font_chinese_group.custom.fontset = {
    noto = [[\setCJKmainfont{Noto Serif CJK SC}
    \setCJKsansfont{Noto Sans CJK SC}
    \setCJKmonofont{Noto Sans Mono CJK SC}]],
}

M.paragraph_and_line_group.build = function(type)
    type = type or "biasa"
    local reformat_sections = M.paragraph_and_line_group.custom.type[type]
    local res = string.format([[\usepackage{microtype,setspace,indentfirst}
    \usepackage{titlesec,titling,titletoc}
    \usepackage[indent=30pt,skip=10pt]{parskip}
    \onehalfspacing

    %s]], reformat_sections)
    res = make_comment_banner(M.paragraph_and_line_group.title, res)
    return res
end

M.paragraph_and_line_group.custom.type = {

    biasa = [[\renewcommand{\maketitle}{ % change layout for title and author
    % tiny,scriptsize,footnotesize,small,normalsize,large,Large,LARGE,huge,Huge,HUGE
    \noindent\normalsize\theauthor
    \begin{center}
        \large\bfseries\thetitle
    \end{center}
    \vspace{1em}
    }]],

    makalah = [[% Change position and style for title, chapter, subsections
    \renewcommand{\thechapter}{\Roman{chapter}}
    \renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}

    \titleformat{\chapter}[display] % shape
    {\bfseries\normalsize\center} % format
    {\MakeUppercase\chaptertitlename \ \thechapter} % label
    {-1.2em} % sep
    {\MakeUppercase} % before-code [] %% aftercode

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

    \titlecontents{chapter} % omit backslash
    [0em]
    {\vspace{1em}} % above-code
    {\bfseries\MakeUppercase\chaptertitlename~\thecontentslabel\quad\uppercase} % numbered-entry-format
    {\bfseries\uppercase} % numberedless-entry-format
    {~\titlerule*[.75em]{.}\contentspage} % filler-page-format

    %% Add new numbered environment for data
    \newcounter{datacounter}
    \setcounter{datacounter}{1}
    \newenvironment{textdata}[1][Data]
    {
    \singlespacing
    \textbf{#1 \thedatacounter}
    \list{}{\rightmargin\leftmargin}
    \item\relax
    \addtocounter{datacounter}{1}
    }
    {\endlist{}}
    ]],
}


-- use this as last package
M.references_group.build = function()
    local res = string.format([[\usepackage{hyperref}
    \usepackage{caption,subcaption}
    \hypersetup{colorlinks=false,citecolor=blue,linkcolor=blue,urlcolor=blue}
    \urlstyle{same}]])
    res = make_comment_banner(M.references_group.title, res)
    return res
end

M.bibliography_group.build = function()
    local res = string.format([[\usepackage[backend=biber,style=authoryear,hyperref=true,]{biblatex}
    \addbibresource{ref.bib}]])
    res = make_comment_banner(M.bibliography_group.title, res)
    return res
    -- %% \DeclareFieldFormat{url}{\url{#1}}
    -- %% \renewbibmacro{in:}{} %% removes in
    -- %% \DeclareFieldFormat{pages}{#1} %% removes pages
    -- %% \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}]]
end

M.images_group.build = function()
    local home = vim.fn.expand("~")
    local img_sources = ""
    local paths = {
        home .. "/.local/share/commonly_used_images/",
    }
    for _, v in ipairs(paths) do
        img_sources = img_sources .. "{" .. v .. "}"
    end
    local res = string.format([[\usepackage{graphicx}
    \graphicspath{ %s }]], img_sources)
    res = make_comment_banner(M.images_group.title, res)
    return res
end

return M

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
