local utils = require("utils")

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    ".git/",
                    "node_modules",
                    "vendor",
                    "build/",
                    "dist/",
                    ".svelte-kit/",
                    "__pycache__",
                    "venv/",
                },
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                    no_ignore = false,
                    hidden = true,
                    previewer = false,
                },
                git_files = {
                    theme = "dropdown",
                    previewer = false,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                diagnostics = {
                    theme = "ivy",
                    initial_mode = "normal",
                    previewer = false,
                    layout_config = {
                        bottom_pane = {
                            height = 10,
                        },
                    },
                },
                jumplist = {
                    theme = "ivy",
                    initial_mode = "normal",
                    previewer = false,
                    layout_config = {
                        bottom_pane = {
                            height = 10,
                        },
                    },
                },
                lsp_document_symbols = {
                    theme = "dropdown",
                },
                lsp_dynamic_workspace_symbols = {
                    theme = "dropdown",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        telescope.load_extension("fzf")

        utils.map("n", "<C-p>", "<cmd>Telescope find_files<CR>")
        utils.map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
        utils.map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
        utils.map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
        utils.map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
    end,
}
