---@diagnostic disable: undefined-global

--[[
    inline math: $$, \( \), \begin{math}...\end{math}
    display math: \[\], \begin{displaymath}...\end{displaymath}, \begin{equation}...\end{equation}

]]

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

local make_section_title = function(_, _, title)
    return string.format("%s %s %s", "%%", string.upper(title),
        string.rep("%", 80 - 4 - string.len(title)))
end

local parline_pkg = {
    ["microtype"] = {},
    ["titlesec"] = {},
    ["titling"] = {},
    ["setspace"] = {},
    ["lipsum"] = {},
    ["parskip"] = { indent = "30pt" },
    ["geometry"] = { left = "4cm", top = "3cm", right = "3cm", bottom = "3cm" },
}

local make_usepackage_string = function (packages, options)
    packages = packages or ""
    options = options or ""
    local res = "\\usepackage"
    if (string.match(packages, ",") and options == "") or ( packages ~= "" and options == "") then --multiple package
        res = res .. "{" .. packages .. "}"
    elseif options ~= "" and packages ~= "" then
        res = res .. "[" .. options .. "]{" .. packages .. "}"
    else
        return "aoeuaoeu"
    end
    print(res)
    return res
end

local mytest = function(position, packages)
    return d(position, function()
        local choices = {}
        table.insert(choices, t(""))

        local options_jump_stop = {} -- use this inside fmta
        local options_value = {} -- use this in nodes
        local options_insert_nodes = {} -- use this in nodes

        local pkgs_without_opts = {}
        local my_usepackages_cmd = ""

        for pkg_name, options in pairs(packages) do
            if next(options) ~= nil then
                local concat = ""
                for key, value in pairs(options) do
                    concat = concat .. key .. "=<" .. key .. ">,"
                    options_value[pkg_name] = options
                    options_insert_nodes[key] = value
                end
                options_jump_stop[pkg_name] = concat
            else
                table.insert(pkgs_without_opts, pkg_name)
            end
        end

        my_usepackages_cmd = my_usepackages_cmd .. make_usepackage_string(table.concat(pkgs_without_opts, ","))

        for pkg_name, options in pairs(options_jump_stop) do
            my_usepackages_cmd = string.format("%s\n%s", my_usepackages_cmd, make_usepackage_string(pkg_name, options))
        end

        -- local element_num = 1
        -- for k, v in pairs(options_insert_nodes) do
        --     options_insert_nodes[k] = "i(" .. element_num .. "," .. v .. ")"
        --     element_num = element_num + 1
        -- end

        print(
            -- "jump_stop = " .. vim.inspect(options_jump_stop),
            -- "\nopt_values = " .. vim.inspect(options_value),
            -- "\n w/o opt : " .. vim.inspect(pkgs_without_opts),
            "\n w/ opt : " .. vim.inspect(my_usepackages_cmd),
            "insert nodes : " .. vim.inspect(options_insert_nodes)
        )

        -- TODO:
        return sn(nil, fmta([[]], {
            function ()
                local M = {}
                return M
            end
        }))
    end)
end



--[[ setup common configuration for some packages ]]
return {

    s({ trig = "tesd", dscr = "Setup default page layout" },
        fmta([[
        <sect_separator>
        <sect_title>
        <packages>
        <sect_separator>
        ]],
            {
                sect_separator = t(string.rep("%", 80)),
                sect_title = f(make_section_title, {}, { user_args = { "page layout" } }),
                packages = mytest(1, parline_pkg),
            }),
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
    ),

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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
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
        { condition = cond.in_preamble and cond.line_begin, show_condition = cond.in_preamble }
    ),

}
