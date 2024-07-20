require("conform").setup({
    notify_on_error = false,
    format_on_save = function()
        if vim.g.disable_autoformat then
            return
        end
        -- return { async = false, timeout_ms = 500, lsp_format = "fallback" }
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "biome", "prettierd", "prettier" } },
    },
})

vim.api.nvim_create_user_command("ToggleFormatting", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    local state = vim.g.disable_autoformat and "disabled" or "enabled"
    vim.notify("Autoformat-on-save " .. state, vim.log.levels.INFO)
end, {
    desc = "Toggle global autoformat-on-save",
})
