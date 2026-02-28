local utils = require("utils")

return {
    "github/copilot.vim",
    config = function()
        vim.cmd("Copilot disable")

        utils.map("n", "<leader>cpe", "<cmd>Copilot enable<CR> <cmd>lua print('Copilot attached')<CR>")
        utils.map("n", "<leader>cpd", "<cmd>Copilot disable<CR> <cmd>lua print('Copilot detached')<CR>")
        utils.map("i", "<A-[>", "<Plug>(copilot-previous)")
        utils.map("i", "<A-]>", "<Plug>(copilot-next)")
        utils.map("i", "<A-\\>", "<Plug>(copilot-suggest)")
        vim.keymap.set("i", "<C-e>", 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
        })
        vim.g.copilot_no_tab_map = true
    end,
}
