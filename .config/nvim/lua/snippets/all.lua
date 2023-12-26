---@diagnostic disable: undefined-global

-- local cond = require("tex.utils.conditions")
local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

return {
    -- s("trig", t("loaded!!")),

    -- A fun zero subscript snippet
    --[[ s({ trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "<>_{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                t("0")
            }
        )
    ), ]]

    --[[ s({ trig = "test", snippetType = "autosnippet" },
        { t("The current line number is even") },
        { condition = cond.is_even_line }
    ), ]]

}
