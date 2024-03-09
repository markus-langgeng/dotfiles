---@diagnostic disable: undefined-global

local cond = require("snippets.tex.utils.conditions")
local helper = require("snippets.helper")

local mytest = function(index)
    return f(function(args)
        --            ^ is a list of tables, so it looks like this { {}, {}, {},  {}}
        local parts = vim.split(args[1][1], ".", { plain = true })
        -- print(vim.inspect(args), vim.inspect(parts[#parts]))
        return parts[#parts] or ""
    end, { index })
end

local mycurtime = function()
    return f(function()
        return os.date("%D - %H:%M")
    end)
end

return {

    s("todo", t("TODO: ")),
    s("fix", t("FIX: ")),
    s("warn", t("WARN: ")),
    s("note", t("NOTE: ")),
    s("perf", t("PERF: ")),

    -- s("curtime", f(function()
    --     return os.date("%D - %H:%M")
    -- end)),
    --
    -- s("curtime2", mycurtime()),
    --
    -- s("test2", fmta([[halo <> = apa kabar <>]],
    --     {
    --         i(1),
    --         mytest(1),
    --     }
    -- )),
    --
    -- s("test", fmta([[halo <> = apa kabar <>]],
    --     {
    --         i(1),
    --         f(function(args)
    --             print(vim.inspect(args), args)
    --             return args[1]
    --         end, { 1 }),
    --     }
    -- )),
    --
    -- -- dynamic nodes returns snippets nodes
    --
    -- -- coba tes: uaeouoe pilihan -> statis
    --
    -- s("dtest", fmta([[
    -- coba tes: <> pilihan ->> <>
    -- ]], {
    --         i(1),
    --         d(2, function ()
    --             local nodes = {}
    --             table.insert(nodes, t(""))
    --
    --             local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    --             for _, line in ipairs(lines) do
    --                 if line:match("^-- mau maem") then
    --                     table.insert(nodes, t("makan dulu"))
    --                 end
    --             end
    --
    --             return sn(nil, c(1, nodes))
    --             -- return sn(nil, c(1, { t("first choice"), t("second choice"), t("third choice"),}))
    --         end),
    --     })),
    --
}
