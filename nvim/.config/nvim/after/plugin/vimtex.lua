vim.g.Tex_DefaultTargetFormat = "pdf"
vim.g.Tex_MultipleCompileFormats = "pdf,bibtex,pdf"

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
    options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape",
    },
    build_dir = "build",
}
