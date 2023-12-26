local M = {}
local ls = require("luasnip")
local extras = require("luasnip.extras")
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

-- Be sure to explicitly define these LuaSnip node abbreviations!
M.ls = require("luasnip")
M.extras = require("luasnip.extras")
M.events = require("luasnip.util.events")
M.ai = require("luasnip.nodes.absolute_indexer")
M.fmt = require("luasnip.extras.fmt").fmt
M.fmta = require("luasnip.extras.fmt").fmta
M.conds = require("luasnip.extras.expand_conditions")
M.postfix = require("luasnip.extras.postfix").postfix
M.types = require("luasnip.util.types")
M.parse = require("luasnip.util.parser").parse_snippet
M.s = ls.snippet
M.sn = ls.snippet_node
M.isn = ls.indent_snippet_node
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.c = ls.choice_node
M.d = ls.dynamic_node
M.r = ls.restore_node
M.l = extras.lambda
M.rep = extras.rep
M.p = extras.partial
M.m = extras.match
M.n = extras.nonempty
M.dl = extras.dynamic_lambda
M.ms = ls.multi_snippet
-- local k = require("luasnip.nodes.absolute_indexer").new_key

function M.get_visual(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return M.sn(nil, M.i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return M.sn(nil, M.i(1, ''))
    end
end

return M
