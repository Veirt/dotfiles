return {

    "stevearc/conform.nvim",

    config = function()
        local conform = require("conform")
        local util = require("conform.util")

        local prettier_files = {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.ts",
            ".prettierrc.mts",
            ".prettierrc.cts",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
            "prettier.config.ts",
            "prettier.config.mts",
            "prettier.config.cts",
        }

        local function read_json(path)
            local file = io.open(path, "r")
            if not file then
                return nil
            end
            local ok, decoded = pcall(vim.json.decode, file:read("*all"))
            file:close()
            return ok and decoded or nil
        end

        local function prettier_root(self, ctx)
            return vim.fs.root(ctx.dirname, function(name, path)
                if vim.tbl_contains(prettier_files, name) then
                    return true
                end

                if name == "package.json" then
                    local package_data = read_json(vim.fs.joinpath(path, name))
                    return package_data and package_data.prettier ~= nil or false
                end

                return false
            end)
        end

        local function web_formatter_then_rustywind(bufnr)
            for _, formatter in ipairs({ "biome", "oxfmt", "prettierd", "prettier" }) do
                if conform.get_formatter_info(formatter, bufnr).available then
                    return { formatter, "rustywind" }
                end
            end
            return { "rustywind" }
        end

        conform.setup({
            notify_on_error = true,

            format_on_save = function()
                if vim.g.disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,

            formatters = {
                biome = {
                    cwd = util.root_file({ "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" }),
                    require_cwd = true,
                },
                oxfmt = {
                    cwd = util.root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
                    require_cwd = true,
                },
                prettierd = {
                    cwd = prettier_root,
                    require_cwd = true,
                },
                prettier = {
                    cwd = prettier_root,
                    require_cwd = true,
                },
            },

            formatters_by_ft = {
                javascript = { "biome", "oxfmt", "prettierd", stop_after_first = true },
                typescript = { "biome", "oxfmt", "prettierd", stop_after_first = true },
                javascriptreact = web_formatter_then_rustywind,
                typescriptreact = web_formatter_then_rustywind,

                json = { "biome", "prettierd", "prettier", stop_after_first = true },
                jsonc = { "biome", "prettierd", "prettier", stop_after_first = true },

                css = { "biome", "prettierd", "rustywind", stop_after_first = true },
                astro = { "prettierd", "prettier", stop_after_first = true },
                svelte = { "prettierd", "rustywind" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                tex = { "tex-fmt", stop_after_first = true },
                typst = { "prettypst", stop_after_first = true },
                nix = { "nixfmt" },

                lua = { "stylua" },
                python = { "black", "isort" },
                -- yaml = { "yamlfmt", stop_after_first = true },
            },
        })

        vim.api.nvim_create_user_command("ToggleFormatting", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            local state = vim.g.disable_autoformat and "disabled" or "enabled"
            vim.notify("Autoformat-on-save " .. state, vim.log.levels.INFO)
        end, {
            desc = "Toggle global autoformat-on-save",
        })
    end,
}
