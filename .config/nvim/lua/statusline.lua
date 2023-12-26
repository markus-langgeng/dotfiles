local M = {}

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
    local parts = {
        -- [[ %-.15([%l,%v]%) %=%<%F%= %-.15(%y %P%) ]],
        -- vim.fn.luaeval(require("statusline").diagnostic_status()),
        [[ %-.15([%l:%p%%]%)]],

        [[%-.15(%{luaeval("require('statusline').diagnostic_status()")}%)]],

        [[%=%<%F%= ]],

        [[%-.20(%y %P%) ]],
    }

    return table.concat(parts, " ")
end

return M
