require("conform").setup({
    notify_on_error = false,
    format_on_save = function()
        if vim.g.disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        astro = { "prettier", stop_after_first = true },
        markdown = { "prettierd" },
    },
})

vim.api.nvim_create_user_command("ToggleFormatting", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    local state = vim.g.disable_autoformat and "disabled" or "enabled"
    vim.notify("Autoformat-on-save " .. state, vim.log.levels.INFO)
end, {
    desc = "Toggle global autoformat-on-save",
})
