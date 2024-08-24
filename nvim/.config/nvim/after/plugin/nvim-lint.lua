-- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/lint.lua
local lint = require("lint")
lint.linters_by_ft = {
    dockerfile = { "hadolint" },
}

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})
