local env = require("os").getenv
local doctypes = require("snippets.tex.utils.enums").Types
local engines = require("snippets.tex.utils.enums").Engines
local docclasses = require("snippets.tex.utils.enums").Classes
local packages = require("snippets.tex.templates.packages")
local separator = string.rep("%", 80)

-- create modules if we want to combine this with another snippets
local M = {}

M.current_type = doctypes.biasa.name
M.current_engine = engines.lualatex.name
M.current_class = docclasses.article.name
M.write_chinese = false

M.engine = function(engine)
    local res = "%! TeX program = lualatex"
    if engine == "xelatex" then
        res = "%! TS-program = xelatex"
    end
    return res
end

M.docclass = function(class, papersize, fontsize)
    class = class or "article"
    papersize = papersize or "a4paper"
    fontsize = fontsize or "12pt"
    local res = string.format([[\documentclass[%s,%s]{%s}]], papersize, fontsize, class)
    return res
end

M.title = function(title)
    local filename = vim.fn.expand("%:t:r"):gsub("%p+", " "):gsub("(%l)(%w*)",
        function(a, b) return string.upper(a) .. b end)
    title = title or filename or "Judul"
    return title
end

M.author = function(author) return author or env("USER") or "" end

M.date = function() return "\\today" end

M.build_packages_setup = function()
    local res = {}

    if M.current_type == "tugas" then
        table.insert(res, packages.page_layout_group.build(_, "4cm", "3cm"))
        table.insert(res, packages.language_and_font_group.build())
        if M.write_chinese then table.insert(res, packages.language_and_font_chinese_group.build(_)) end
        table.insert(res, packages.paragraph_and_line_group.build()) -- blm ada utk tipe tugas

    elseif M.current_type == "makalah" then
        table.insert(res, packages.page_layout_group.build(_, "4cm", "3cm"))
        table.insert(res, packages.language_and_font_group.build("id", "ms"))
        if M.write_chinese then table.insert(res, packages.language_and_font_chinese_group.build(_)) end
        table.insert(res, packages.paragraph_and_line_group.build(M.current_type))
        table.insert(res, packages.images_group.build())
        table.insert(res, packages.bibliography_group.build())
        table.insert(res, packages.references_group.build())

    elseif M.current_type == "catatan" then
        table.insert(res, packages.page_layout_group.build())
        table.insert(res, packages.language_and_font_group.build("id", "liberation"))
        if M.write_chinese then table.insert(res, packages.language_and_font_chinese_group.build(_)) end
        table.insert(res, packages.paragraph_and_line_group.build(M.current_type))

    else
        table.insert(res, packages.page_layout_group.build())
        if M.write_chinese then table.insert(res, packages.language_and_font_chinese_group.build(_)) end
    end

    return table.concat(res, "\n\n")
end

M.build_title = function(title, author)
    local res = string.format([[\title{%s}
    \author{%s}
    \date{%s}]], M.title(title), M.author(author), M.date())
    return res
end

-- The function that matters the most
M.build_preamble_template = function(doctype, engine, class, write_chinese)
    if type(doctype) ~= "table" then
        error("Doctype has to be an enum member")
    end
    if type(engine) ~= "table" then
        error("Engine has to be an enum member")
    end
    if type(class) ~= "table" then
        error("Class has to be an enum member")
    end

    M.current_type = doctype.name or M.current_type
    M.current_engine = engine.name or M.current_engine
    M.current_class = class.name or M.current_class
    M.write_chinese = write_chinese

    local res = string.format([[
    %s

    %s

%s


    %s
    %s
    %s
    ]],
        M.engine(M.current_engine),
        M.docclass(M.current_class, _, _),
        M.build_packages_setup(),
        separator,
        M.build_title(_, _),
        separator
    )

    return res
end

return M
