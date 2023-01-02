-- https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
local M = {}

M.gitsigns = function()
    autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
            vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
            if vim.v.shell_error == 0 then
                vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                vim.schedule(function()
                    require("packer").loader("gitsigns.nvim")
                end)
            end
        end,
    })
end

return M
