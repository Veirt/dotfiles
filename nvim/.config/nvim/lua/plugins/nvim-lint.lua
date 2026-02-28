return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        local uv = vim.uv

        lint.linters_by_ft = {
            dockerfile = { "hadolint" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
        }

        lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)

        local function project_has_eslint(bufnr)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname == "" then
                return false
            end
            local start_dir = vim.fs.dirname(fname)
            local root = vim.fs.root(start_dir, {
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
            })
            return root ~= nil
        end

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
                if
                    (ft == "javascript" or ft == "typescript" or ft == "typescriptreact")
                    and project_has_eslint(bufnr)
                then
                    lint.try_lint("eslint_d")
                end
            end,
        })
    end,
}
