---@diagnostic disable: undefined-global

local helper = require("custom.snippets.utils.helper")
local conditions = require("custom.snippets.utils.conditions")

require("luasnip.session.snippet_collection").clear_snippets("tex")

local M = {}

local fontspec = {
    xsr = [[\textrm]], -- serif (roman)
    xsn = [[\textsf]], -- sans
    xmn = [[\textmn]], -- mono
}

for k, v in pairs(fontspec) do
    local str = v .. "{<>}"
    local snp = function()
        return s({ trig = k, snippetType = "autosnippet" },
            fmta(str, { d(1, helper.get_visual) },
                {
                    condition = conditions.latex.env.document * conditions.latex.pkg.fontspec
                }
            ))
    end
    table.insert(M, snp())
end

local xpinyin = {
    xyy = [[\xpinyin]],
    pyy = [[\pinyin]],
    syy = {
        snp = [[
    \begin{pinyinscope}
        <>
    \end{pinyinscope}
    ]],
        nodes = { i(1) }
    },
}

for k, v in pairs(xpinyin) do
    local str = v
    local snp = function()
        if type(str) == "table" then
            return s({ trig = k, snippetType = "autosnippet" },
                fmta(str.snp, str.nodes),
                {
                    condition = conditions.line_begin *
                        conditions.latex.env.document *
                        conditions.latex.pkg.xpinyin
                })
        end
        return s({ trig = k, snippetType = "autosnippet" },
            fmta(str .. "{<>}", { d(1, helper.get_visual) }),
            { condition = conditions.latex.pkg.xpinyin * conditions.latex.env.document }
        )
    end
    table.insert(M, snp())
end

local polyglossia = function()
    return s({ trig = "xll", snippetType = "autosnippet" },
        fmta([[\textlang{<>}{<>}]], { i(1), i(2) }),
        {
            condition = conditions.latex.pkg.polyglossia * conditions.latex.env.document
        })
end
table.insert(M, polyglossia())

local glossaries = {
    ncc = [[\newacronym]],
    lcc = [[\acrfull]],
    scc = [[\acrshort]],
}

for k, v in pairs(glossaries) do
    local abbreviate = function(index, lower)
        return f(function(sentence)
            local letters = ""
            for word in string.gmatch(sentence[1][1], "%w+") do
                letters = letters .. string.sub(word, 1, 1)
            end
            if lower then letters = string.lower(letters) end
            return letters
        end, { index })
    end

    local str = v .. "{<>}"

    local snp = function()
        if k == "ncc" then
            str = v .. "{<>}{<>}{<>}"
            return s({ trig = k, snippetType = "autosnippet" },
                fmta(str, {
                    abbreviate(1, true),
                    abbreviate(1),
                    d(1, helper.get_visual)
                },
                    { condition = conditions.latex.env.document * conditions.latex.pkg.glossaries }
                ))
        end
        return s({ trig = k, snippetType = "autosnippet" },
            fmta(str, { d(1, helper.get_visual) },
                { condition = conditions.latex.env.document * conditions.latex.pkg.glossaries }
            ))
    end
    table.insert(M, snp())
end

return M
