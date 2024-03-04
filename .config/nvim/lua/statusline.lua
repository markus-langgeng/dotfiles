local M = {}

M.vim_modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

function M.diagnostic_status()
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local diag_msg = {}
    if num_errors > 0 then
        table.insert(diag_msg, "E=" .. num_errors)
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        table.insert(diag_msg, "W=" .. num_warnings)
    end

    local num_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    if num_info > 0 then
        table.insert(diag_msg, "I=" .. num_info)
    end

    local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    if num_hints > 0 then
        table.insert(diag_msg, "H=" .. num_hints)
    end

    return table.concat(diag_msg, " ")
end

function M.statusline()
    -- [[ %-.15([%l,%v]%) %=%<%F%= %-.15(%y %P%) ]],
    -- vim.fn.luaeval(require("statusline").diagnostic_status()),

    local parts = {}

    local cur_mode = vim.api.nvim_get_mode().mode
    cur_mode = M.vim_modes[cur_mode]
    local diags = M.diagnostic_status() or ""

    if diags ~= "" then
        table.insert(parts, string.format("%%(-- %s -- [%s]%%)", cur_mode, diags))
    else
        table.insert(parts, string.format("%%(-- %s --%%)", cur_mode))
    end

    if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "lazy" or vim.bo.filetype == "mason" then
        return " " .. table.concat(parts, " ")
    end

    table.insert(parts, "%(%{get(b:,'gitsigns_status','')}|%{get(b:,'gitsigns_head','')}%)")

    table.insert(parts, "%=%(%F%)%=")
    table.insert(parts, "%(%y")
    table.insert(parts, "(%l,%v,%p%%)%)")

    parts[1] = " " .. parts[1]
    parts[#parts] = parts[#parts] .. " "

    return table.concat(parts, " ")
end

return M
