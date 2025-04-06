local present, peek = pcall(require, "peek")

if not present then
    return
end

peek.setup()

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
