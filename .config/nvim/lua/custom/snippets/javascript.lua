---@diagnostic disable: undefined-global

local helper = require("custom.snippets.utils.helper")

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
