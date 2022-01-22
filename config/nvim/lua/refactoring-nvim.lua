require("refactoring").setup({})
vim.api.nvim_set_keymap(
    "n",
    "<leader>rp",
    ":lua require('refactoring').debug.printf({below = false})<CR>",
    { noremap = true }
)
-- Print var: this remap should be made in visual mode
vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
