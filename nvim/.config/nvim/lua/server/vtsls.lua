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
    local vtsls = vim.fn.exepath("vtsls")
    if vtsls == "" then
        vim.notify("vtsls executable not found in Neovim's PATH", vim.log.levels.ERROR)
        return
    end

    vim.lsp.config("vtsls", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            -- vtsls is an import-actions-only companion to tsgo.
            client.server_capabilities.completionProvider = nil
            client.server_capabilities.hoverProvider = nil
            client.server_capabilities.definitionProvider = nil
            client.server_capabilities.referencesProvider = nil
            client.server_capabilities.renameProvider = nil
            client.server_capabilities.documentFormattingProvider = nil
            client.server_capabilities.documentRangeFormattingProvider = nil
            client.handlers["textDocument/publishDiagnostics"] = function() end

            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end
        end,
        cmd = function(dispatchers, config)
            local command = vtsls
            local root = (config or {}).root_dir
            if root then
                local local_command = vim.fs.joinpath(root, "node_modules/.bin/vtsls")
                if vim.fn.executable(local_command) == 1 then
                    command = local_command
                end
            end
            return vim.lsp.rpc.start({ command, "--stdio" }, dispatchers)
        end,
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_dir = root_dir,
    })

    vim.lsp.enable("vtsls")
end

return M
