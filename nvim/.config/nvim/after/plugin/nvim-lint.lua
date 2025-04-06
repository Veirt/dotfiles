-- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/lint.lua

local present, lint = pcall(require, "lint")

if not present then
    return
end

lint.linters_by_ft = {
    dockerfile = { "hadolint" },
    typescriptreact = { "eslint_d" },
}

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})
