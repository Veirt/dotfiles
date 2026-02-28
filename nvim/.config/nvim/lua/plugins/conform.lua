return {

    "stevearc/conform.nvim",

    config = function()
        require("conform").setup({
            notify_on_error = true,

            format_on_save = function()
                if vim.g.disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,

            formatters = {
                -- ["biome-check"] = {
                --     condition = has_biome,
                -- },
                -- prettierd = {
                --     condition = function(ctx)
                --         return not has_biome(ctx) and has_prettier(ctx)
                --     end,
                -- },
            },

            formatters_by_ft = {
                javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
                typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "biome-check", "rustywind", stop_after_first = true },
                typescriptreact = { "biome-check", stop_after_first = true },

                json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
                jsonc = { "biome-check", "prettierd", "prettier", stop_after_first = true },

                css = { "prettierd", "rustywind", stop_after_first = true },
                astro = { "prettierd", "prettier", stop_after_first = true },
                svelte = { "prettierd", "rustywind" },
                markdown = { "prettierd", "prettier", stop_after_first = true },

                lua = { "stylua" },
                python = { "black", "isort" },
                -- yaml = { "yamlfmt", stop_after_first = true },
            },
        })

        vim.api.nvim_create_user_command("ToggleFormatting", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            local state = vim.g.disable_autoformat and "disabled" or "enabled"
            vim.notify("Autoformat-on-save " .. state, vim.log.levels.INFO)
        end, {
            desc = "Toggle global autoformat-on-save",
        })
    end,
}
