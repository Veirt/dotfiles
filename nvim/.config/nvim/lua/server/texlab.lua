local M = {}

M.setup = function()
    require("lspconfig")["texlab"].setup({
        settings = {
            texlab = {
                auxDirectory = "build",
                build = {
                    args = {
                        "-pdf",
                        "-interaction=nonstopmode",
                        "-synctex=1",
                        "-shell-escape",
                        "-auxdir=./build",
                        "-outdir=./build",
                        "%f",
                    },
                    onSave = true,
                    forwardSearchAfter = true,
                },
                forwardSearch = {
                    executable = "zathura",
                    args = { "--synctex-forward", "%l:1:%f", "%p" },
                },
            },
        },
    })
end

-- M.setup = function()
--     require("lspconfig")["texlab"].setup({
--         settings = {
--             texlab = {
--                 auxDirectory = "build",
--                 build = {
--                     executable = "tectonic",
--                     args = {
--                         "-X",
--                         "compile",
--                         "%f",
--                         "--synctex",
--                         "--keep-logs",
--                         "--keep-intermediates",
--                     },
--                     onSave = true,
--                     forwardSearchAfter = true,
--                 },
--                 forwardSearch = {
--                     executable = "zathura",
--                     args = { "--synctex-forward", "%l:1:%f", "%p" },
--                 },
--             },
--         },
--     })
-- end

return M
