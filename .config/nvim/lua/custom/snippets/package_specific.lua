---@diagnostic disable: undefined-global

local helper = require("custom.snippets.utils.helper")
local conditions = require("custom.snippets.utils.conditions")

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
            fmta(str, { d(1, helper.get_visual) }, {
                condition = conditions.latex.pkg.fontspec * conditions.latex.env.document
            }))
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
    \begin{pinyinscope}
    ]],
        nodes = { i(1) }
    },
}

local polyglossia = function()
    return s({ trig = "xll", snippetType = "autosnippet" },
        fmta([[\textlang{<>}{<>}]], { i(1), i(2) }),
        {
            condition = conditions.latex.pkg.polyglossia * conditions.latex.env.document
        })
end
table.insert(M, polyglossia())

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


return M
