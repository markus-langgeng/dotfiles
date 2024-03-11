---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

return {

    s({ trig = "fuck", snippetType = "autosnippet", },
        fmta([[
        function fuckMe(<args>) {
            fuckYall();
        }
        ]],
            { args = i(0), }
        )

    ),

}
