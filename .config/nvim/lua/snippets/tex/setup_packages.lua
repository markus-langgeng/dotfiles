---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

-- local make_usepackage = function(_, _, user_arg1, user_arg2)
--     vim.print(vim.inspect(user_arg1))
--     return string.format("\\usepackage[]{%s}", user_arg1)
-- end

local make_section_title = function(_, _, title)
    return string.format("%s %s %s", "%%", string.upper(title),
        string.rep("%", 80 - 4 - string.len(title)))
end

local page_layout_pkgs = {
    geometry = { left = "4cm", top = "3cm", right = "3cm", bottom = "3cm", "showframe" },
    blindtext = "",
}

local setup_packages = function(trig, dscr, title, packages)
    packages = packages or {}

    local sect_separator = string.rep("%", 80)
    local sect_title = make_section_title(title)
    local result = string.format("%s\n%s\n", sect_separator, sect_title)

    -- for k, v in pairs(packages) do
    --     print(vim.inspect(k), vim.inspect(v), v[1])
    -- end

    s({ trig = trig, dscr = dscr }, fmta(result, {}))

    result = result .. sect_separator
    print(result)

    -- return s({ trig = trig, dscr = dscr },
    --     fmta(result)
    -- )
end

--[[ setup common configuration for some packages ]]
return {

    -- setup_packages("setup_page_layout", "Setup default layout", "Page Layout", page_layout_pkgs),

    s({ trig = "s_pagelayout", dscr = "Setup default page layout" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage[<page_size>,<margins>,<showframe>]{geometry}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "page layout" } }),
                page_size = i(1, "a4paper"),
                margins = c(2, {
                    i(nil, "left=4cm,top=3cm,right=3cm,bottom=3cm"),
                    i(nil, "left=3cm,top=3cm,right=3cm,bottom=3cm"),
                    i(nil, "")
                }),
                showframe = c(3, { t(""), t("showframe"), }),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    s({ trig = "s_langfont_id", dscr = "Setup default languages and fonts" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage{indentfirst,polyglossia,fontspec}
        <mainlang_otherlang>
        % \setmainfont{Times New Roman} % \setmainfont{Times New Roman}
        % \setsansfont{Arial}           % \setsansfont{Arial}
        % \setmonofont{}                % \setmonofont{}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "Languages and Fonts" } }),
                mainlang_otherlang = c(1, {
                    sn(nil,
                        { i(1), t({ "\\setdefaultlanguage[variant=indonesian]{malay}", "\\setotherlanguages{english}" }) }),
                    sn(nil,
                        { i(1), t({ "\\setdefaultlanguage{english}", "\\setotherlanguages[variant=indonesian]{malay}" }) }),
                }),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    s({ trig = "s_langfont_zh", dscr = "Setup default languages and fonts for chinese" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage{indentfirst,xeCJK,xpinyin}
        \setCJKmainfont{<main>}
        \setCJKsansfont{<sans>} % Source Han Sans CN, BabelStone Han
        \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "Languages and Fonts for chinese" } }),
                main = i(1, "Noto Serif CJK SC"),
                sans = i(2, "Source Hna Sans CN"),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    s({ trig = "s_parline", dscr = "Setup default paragagraph and line spacing" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage{microtype,titlesec,titling,setspace,lipsum}
        \usepackage[<indent>]{parskip}
        \onehalfspacing
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "Paragraph and Line Spacing" } }),
                indent = c(1, {
                    i(nil, "indent=30pt"),
                    i(nil, "indent=25pt"),
                    i(nil, "indent=20pt"),
                    i(nil, ""),
                }),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    --[[ %% (reformat title and sections below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % \renewcommand{\maketitle}{
        %     \noindent\normalsize\theauthor
        %     \begin{center}
        %         \large\bfseries\thetitle %large,Large,LARGE,huge,Huge,HUGE
        %     \end{center}
        %     \vspace{1em}
        % }
        % \titleformat*{\section}{\normalsize\bfseries} ]]

    s({ trig = "s_img", dscr = "Setup default settings to import images" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage{graphicx}
        \graphicspath{{<path>/}}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "Paragraph and Line Spacing" } }),
                path = i(1, "img"),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    s({ trig = "s_bib", dscr = "Setup default settings for bibliography" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage[
        backend=biber,
        style=authoryear,
        hyperref=true,
        ]{biblatex}
        %% (reformat stuff below here) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % \renewbibmacro{in:}{} % removes in
        % \DeclareFieldFormat{pages}{#1} % removes pages
        % \renewcommand*{\finentrypunct}{\ifboolexpr{togl {bbx:doi} and not test {\iffieldundef{doi}}}{}{\addperiod}}
        \addbibresource{ref.bib}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "Paragraph and Line Spacing" } }),
            }
        ),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    -- always load this at the end of preamble
    s({ trig = "s_hyperref", dscr = "Setup hypperref" },
        fmta([[
        <sect_separator>
        <sect_title>
        \usepackage{hyperref}
        \hypersetup{colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue}
        \urlstyle{same}
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "references" } }),
            }),
        { condition = cond.in_preamble * cond.line_begin, show_condition = cond.in_preamble }
    ),

    --------------------------------
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

}
