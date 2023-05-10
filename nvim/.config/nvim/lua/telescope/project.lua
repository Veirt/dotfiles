local M = {}

M.project_files = function()
    local opts = {
        -- layout_strategy='vertical',
    }
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        require("telescope.builtin").find_files(opts)
    end
end

return M
