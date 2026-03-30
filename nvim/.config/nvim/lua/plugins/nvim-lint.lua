return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        local eslint_files = {
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            ".eslintrc.yaml",
            ".eslintrc.yml",
            ".eslintrc",
            "eslint.config.js",
            "eslint.config.cjs",
            "eslint.config.mjs",
            "eslint.config.ts",
            "eslint.config.mts",
            "eslint.config.cts",
        }

        local oxlint_files = {
            ".oxlintrc.json",
            ".oxlintrc.jsonc",
            "oxlint.config.ts",
        }

        local function project_has_config(bufnr, markers)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname == "" then
                return false
            end
            local start_dir = vim.fs.dirname(fname)
            return vim.fs.root(start_dir, markers) ~= nil
        end

        local function project_has_eslint(bufnr)
            return project_has_config(bufnr, eslint_files)
        end

        local function project_has_oxlint(bufnr)
            return project_has_config(bufnr, oxlint_files)
        end

        lint.linters_by_ft = {
            dockerfile = { "hadolint" },
            javascript = { "eslint_d", "oxlint" },
            javascriptreact = { "eslint_d", "oxlint" },
            typescript = { "eslint_d", "oxlint" },
            typescriptreact = { "eslint_d", "oxlint" },
        }

        lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)

        local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_group,
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype
                if ft == "dockerfile" then
                    lint.try_lint("hadolint")
                    return
                end
                if ft == "javascript" or ft == "javascriptreact" or ft == "typescript" or ft == "typescriptreact" then
                    if project_has_eslint(bufnr) then
                        lint.try_lint("eslint_d")
                    elseif project_has_oxlint(bufnr) then
                        lint.try_lint("oxlint")
                    end
                end
            end,
        })
    end,
}
