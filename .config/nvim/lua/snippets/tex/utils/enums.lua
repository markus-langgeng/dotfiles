--[[ local enum = function(keys)
    local Enum = {}
    for _, v in ipairs(keys) do
        Enum[v] = { name = v }
    end
    return Enum
end ]]

local M = {}

M.Types = {
    biasa = { name = "biasa" },
    tugas = { name = "tugas" },
    makalah = { name = "makalah" },
    catatan = { name = "catatan" },
}

M.Classes = {
    article = { name = "article" },
    report = { name = "report" },
    book = { name = "book" },
    exam = { name = "exam" },
}

M.Engines = {
    lualatex = { name = "lualatex" },
    xelatex = { name = "xelatex" },
}

return M
