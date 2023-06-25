return {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    widget_guides = { enabled = true, },
    opts = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "dart" },
            callback = function()
                local v_lsp_b = vim.lsp.buf
                local builtin = require("telescope.builtin")
                local bind = vim.keymap.set

                bind("n", "<leader>fl", function() require("telescope").extensions.flutter.commands() end,
                    { desc = "[R]e[n]ame" })

                bind("n", "<leader>rn", function() v_lsp_b.rename() end, { desc = "[R]e[n]ame" })
                bind("n", "<leader>ca", function() v_lsp_b.code_action() end, { desc = "[C]ode [A]ction" })

                bind("n", "gd", function() v_lsp_b.definition() end, { desc = "[G]oto [D]efinition" })
                bind("n", "gr", function() builtin.lsp_references() end, { desc = "[G]oto [R]eferences" })
                bind("n", "gI", function() v_lsp_b.implementation() end, { desc = "[G]oto [I]mplementation" })
                bind("n", "<leader>D", function() v_lsp_b.type_definition() end, { desc = "Type [D]efinition" })
                bind("n", "<leader>ds", function() builtin.lsp_document_symbols() end, { desc = "[D]ocument [S]ymbols" })
                bind("n", "<leader>ws", function() builtin.lsp_dynamic_workspace_symbols() end,
                    { desc = "[W]orkspace [S]ymbols" })

                bind("n", "K", function() v_lsp_b.hover() end, { desc = "Hover Documentation" })
                bind("n", "<C-k>", function() v_lsp_b.signature_help() end, { desc = "Signature Documentation" })
            end
        })

        return {
            lsp = {
                color = { enabled = false },
            },
            widget_guides = {
                enabled = true,
            },
            settings = {
                showTodos = false,
            },
        }
    end,
}
