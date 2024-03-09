---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")
local set_pkg = require("snippets.tex.setup_packages")

-- Utility functions

local make_docclass = function(class, papersize, fontsize, engine)
    class = class or "extarticle"
    papersize = papersize or "a4paper"
    fontsize = fontsize or "12pt"
    engine = engine or "lualatex"
    local res = string.format([[
    %%! TeX program = lualatex

    %s
    ]], "\\documentclass[" .. papersize .. "," .. fontsize .. "]{" .. class .. "}")

    if engine == "xelatex" then
        res = string.format([[
    %%! TeX TS-program = xelatex

    %s
    ]], "\\documentclass[" .. papersize .. "," .. fontsize .. "]{" .. class .. "}")
    end

    return res
end

local make_title = function(title, author)
    local filename = vim.fn.expand("%:t:r"):gsub("%p+", " "):gsub("(%l)(%w*)",
        function(a, b) return string.upper(a) .. b end
    )
    if title == nil then
        title = title or filename
    else
        title = title .. " " .. filename
    end
    author = author or "Author"

    local separator = string.rep("%", 80)
    local res = string.format([[%s
    \title{%s}
    \author{%s}
    \date{\today}
    %s
    ]], separator, title, author, separator)

    return res
end

local final_string = function(doclass, packages, title, body)
    packages = packages or {}
    packages = "\n" .. table.concat(packages, "\n\n")
    local res = string.format([[%s
    %s

    %s


    %s
    ]], doclass, packages, title, body)

    return res
end


-- basic template
-- tugas -> author, lang, font=ms, bib
-- makalah -> author, lang, font=ms, bib, cover
local make_article = function(trig, type, author, mainlang, font, engine)
    trig = trig or ""

    -- predefined options
    local papersize = papersize or "a4paper"
    local packages = {}
    local doclass, title

    -- Packages that I will always use when using article class
    table.insert(packages, set_pkg.pagelayout(papersize, "4cm", "3cm", "3cm", "3cm"))
    table.insert(packages, set_pkg.parline(type))

    if type == "tugas" then
        doclass = make_docclass(_, papersize, "12pt", engine)
        title = make_title("Tugas", author)
        table.insert(packages, set_pkg.langfont(mainlang, font))
        if string.match(trig, "_cina") then
            table.insert(packages, set_pkg.langfont_cn())
        end
    elseif type == "makalah" then
        doclass = make_docclass("report", papersize, "12pt", engine)
        title = make_title("Makalah", author)
        table.insert(packages, set_pkg.langfont(mainlang, font))
        if string.match(trig, "_cina") then
            table.insert(packages, set_pkg.langfont_cn())
        end
        table.insert(packages, set_pkg.bibliography())
        -- TODO: buat utk cover
    else
        doclass = make_docclass(_, papersize, "12pt", engine)
        title = make_title(_, author)
    end

    table.insert(packages, set_pkg.references()) -- put this last
    -- TODO: add \printbibliography[] maybe?
    local body = [[\begin{document}
    \maketitle

    <>

    \end{document}
    ]]

    local res = final_string(doclass, packages, title, body)
    return s({ trig = trig },
        fmta(res, { i(1) }),
        { condition = cond.on_first_line, show_condition = cond.on_first_line }
    )
end


return {
    make_article("t_basic", _, "Langgeng", "id", _, _),
    make_article("t_basic_cina", _, "Langgeng", "id", _, "xelatex"),
    make_article("t_tugas", "tugas", "Markus Langgeng I. S.", "id", "ms", _),
    make_article("t_tugas_cina", "tugas", "Markus Langgeng I. S.", "id", "ms", "xelatex"),
    make_article("t_makalah", "makalah", "Nama: Markus Langgeng Iman Saputra\\\\NIM: 235110400111021", "id", "ms", _),
    make_article("t_makalah_cina", "makalah", "Nama: Markus Langgeng Iman Saputra\\\\NIM: 235110400111021", "id", "ms",
        "xelatex"),
}

--
--
-- s({ trig = "t_pratial_chinese" },
--     fmta([[
--     %! TEX TS-program = xelatex
--
--     \documentclass[12pt]{extarticle}
--
--     <>
--
--     <>
--
--     <>
--
--     <>
--
--     <>
--
--
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--     \title{<>}
--     \author{<>}
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
--             c(3, {
--                 t("% setup_page_layout"),
--                 sn(nil, { t("setup_page_layout"), i(1) }),
--             }),
--             c(4, {
--                 t("% setup_lang_font_zh"),
--                 sn(nil, { t("setup_lang_font_zh"), i(1) }),
--             }),
--             c(5, {
--                 t("% setup_par_line"),
--                 sn(nil, { t("setup_par_line"), i(1) }),
--             }),
--             c(6, {
--                 t("% setup_biblatex"),
--                 sn(nil, { t("setup_biblatex"), i(1) }),
--             }),
--             c(7, {
--                 t("% setup_hyperref"),
--                 sn(nil, { t("setup_hyperref"), i(1) }),
--             }),
--             i(1, "The Title"),
--             i(2, "The Name"),
--             i(0),
--         }
--     ),
--     { condition = cond.on_first_line, show_condition = cond.on_first_line }
-- ),
--
-- s({ trig = "t_full_chinese" },
--     fmta([[
--     %! TEX TS-program = xelatex
--
--     \documentclass[12pt]{extarticle}
--     \usepackage[UTF8]{ctex}
--
--     <>
--
--     <>
--
--     <>
--
--     <>
--
--     <>
--
--
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--     \title{<>}
--     \author{<>}
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
--             c(3, {
--                 t("% setup_page_layout"),
--                 sn(nil, { t("setup_page_layout"), i(1) }),
--             }),
--             c(4, {
--                 t("% setup_lang_font_zh"),
--                 sn(nil, { t("setup_lang_font_zh"), i(1) }),
--             }),
--             c(5, {
--                 t("% setup_par_line"),
--                 sn(nil, { t("setup_par_line"), i(1) }),
--             }),
--             c(6, {
--                 t("% setup_biblatex"),
--                 sn(nil, { t("setup_biblatex"), i(1) }),
--             }),
--             c(7, {
--                 t("% setup_hyperref"),
--                 sn(nil, { t("setup_hyperref"), i(1) }),
--             }),
--             i(1, "The Title"),
--             i(2, "The Name"),
--             i(0),
--         }
--     ),
--     { condition = cond.on_first_line, show_condition = cond.on_first_line }
-- ),
--
--
-- s({ trig = "b_empty" },
--     fmta([[
--     %! TEX TS-program = xelatex
--
--     \documentclass[14pt]{beamer}
--     % \usetheme{}
--     % \usefonttheme{}
--     % \usecolortheme{}
--
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--     \title[<otitle>]{<title>}
--     \subtitle{<subtitle>}
--     \author[<oauthor>]{<author>}
--     \institute[<oinstitute>]{<institute>}
--     \date[<odate>]{<date>}
--
--     % \logo{\includegraphics...}
--     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--
--
--     \begin{document}
--     \frame{\titlepage}
--
--     <>
--
--     \end{document}
--     ]],
--         {
--             otitle     = i(2, "Short Title"),
--             title      = i(1, "Awesome Full-length Title"),
--             subtitle   = i(3, "Nice Subtitle"),
--             oauthor    = i(5, "Langgeng, Nggenglang"),
--             author     = i(4, "M.~Langgeng\\inst{1} \\and M.~Nggenglang\\inst{2}"),
--             oinstitute = i(7, "UB"),
--             institute  = i(6,
--                 "\\inst{1} Fakultas Ilmu Budaya\\\\Universitas Brawijaya \\and \\inst{2} Fakultas Ilmu Budaya\\\\Universitas Brawijaya"),
--             odate      = i(9, "KB 2024"),
--             date       = i(8, "Suatu Pertemuan, April 2024 wkwkw"),
--             i(0, ""),
--         }
--     ),
--     { condition = cond.on_first_line, show_condition = cond.on_first_line }
-- ),
-- }
