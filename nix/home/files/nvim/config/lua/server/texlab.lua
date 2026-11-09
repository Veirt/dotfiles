local M = {}

M.setup = function()
    vim.lsp.config("texlab", {
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
    vim.lsp.enable("texlab")
end

return M
