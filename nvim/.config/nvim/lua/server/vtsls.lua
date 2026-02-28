local M = {}

local uv = vim.uv

local function file_exists(path)
    return uv.fs_stat(path) ~= nil
end

local function get_root()
    local markers = {
        "deno.json",
        "deno.jsonc",
        "package.json",
        ".git",
        "tsconfig.json",
        "jsconfig.json",
    }

    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)
    local start_dir = (#bufname > 0) and vim.fs.dirname(bufname) or uv.cwd()

    local root = vim.fs.root(start_dir, markers)
    return root or uv.cwd()
end

local function is_deno_project(root)
    return file_exists(root .. "/deno.json") or file_exists(root .. "/deno.jsonc")
end

local function has_eslint_config(root)
    return file_exists(root .. "/.eslintrc.js")
        or file_exists(root .. "/.eslintrc.json")
        or file_exists(root .. "/.eslintrc.yaml")
        or file_exists(root .. "/.eslintrc.yml")
end

M.setup = function(capabilities)
    local root = get_root()
    local deno_mode = is_deno_project(root)
    local eslint_mode = has_eslint_config(root)

    local vtsls_base = require("vtsls").lspconfig or {}

    vim.lsp.config(
        "vtsls",
        vim.tbl_deep_extend("force", vtsls_base, {
            capabilities = capabilities,
            single_file_support = false,
            root_dir = root,
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {},
                    },
                },
            },
        })
    )

    vim.lsp.config("denols", {
        capabilities = capabilities,
        single_file_support = false,
        root_dir = root,
        init_options = {
            enable = true,
            lint = true,
            unstable = true,
        },
    })

    vim.lsp.config("eslint", {
        capabilities = capabilities,
        root_dir = root,
    })

    if deno_mode then
        vim.lsp.enable("denols")
    else
        vim.lsp.enable("vtsls")

        if eslint_mode then
            vim.lsp.enable("eslint")
        end
    end
end

return M
