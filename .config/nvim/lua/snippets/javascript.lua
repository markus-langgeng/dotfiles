---@diagnostic disable: undefined-global

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
