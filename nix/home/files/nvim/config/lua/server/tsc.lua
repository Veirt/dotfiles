local M = {}

local function root_dir(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(#name > 0 and vim.fs.dirname(name) or vim.uv.cwd(), {
        "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock", "bun.lockb",
        "tsconfig.json", "jsconfig.json", ".git",
    }) or vim.uv.cwd()
    if on_dir then on_dir(root) else return root end
end

M.setup = function(capabilities)
    local tsc = vim.fn.exepath("tsc")
    if tsc == "" then
        vim.notify("tsc executable not found in Neovim's PATH", vim.log.levels.ERROR)
        return
    end

    vim.lsp.config("tsc", {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        end,
        cmd = { tsc, "--lsp", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = root_dir,
    })
    vim.lsp.enable("tsc")
end

return M
