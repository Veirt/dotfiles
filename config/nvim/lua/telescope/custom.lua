-- Dont preview binaries
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job
        :new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(function()
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                    end)
                end
            end,
        })
        :sync()
end

require("telescope").setup({
    defaults = {
        buffer_previewer_maker = new_maker,
        file_ignore_patterns = { "node_modules", "vendor", "__pycache__", "target" },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
        },
        git_files = {
            theme = "dropdown",
            previewer = false,
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

require("telescope").load_extension("fzf")
