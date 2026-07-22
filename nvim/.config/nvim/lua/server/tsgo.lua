local M = {}

local function root_dir(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local start = (#bufname > 0) and vim.fs.dirname(bufname) or vim.uv.cwd()
    local root = vim.fs.root(start, {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "bun.lock",
        "bun.lockb",
        "tsconfig.json",
        "jsconfig.json",
        ".git",
    }) or vim.uv.cwd()
    if on_dir then
        on_dir(root)
    else
        return root
    end
end

M.setup = function(capabilities)
    local tsgo = vim.fn.exepath("tsgo")
    if tsgo == "" then
        vim.notify("tsgo executable not found in Neovim's PATH", vim.log.levels.ERROR)
        return
    end

    vim.lsp.config("tsgo", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end
        end,
        cmd = function(dispatchers, config)
            local command = tsgo
            local root = (config or {}).root_dir
            if root then
                local local_command = vim.fs.joinpath(root, "node_modules/.bin/tsgo")
                if vim.fn.executable(local_command) == 1 then
                    command = local_command
                end
            end
            return vim.lsp.rpc.start({ command, "--lsp", "--stdio" }, dispatchers)
        end,
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_dir = root_dir,
    })

    vim.lsp.enable("tsgo")

end

return M
