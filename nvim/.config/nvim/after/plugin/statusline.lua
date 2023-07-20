local modes = {
    ["n"] = "󰋜 ",
    ["nov"] = "󰋜 ",
    ["noV"] = "󰋜 ",
    ["no"] = "󰋜 ",
    ["niI"] = "󰋜 ",
    ["niR"] = "󰋜 ",
    ["niV"] = "󰋜 ",

    ["i"] = " ",
    ["ic"] = " ",
    ["ix"] = " ",
    ["s"] = " ",
    ["S"] = " ",

    ["v"] = "󰈈 ",
    ["V"] = "󰉸 ",
    ["CTRL-V"] = "󰉸 ",
    ["r"] = " ",
    ["r?"] = " ",
    ["c"] = " ",
    ["t"] = " ",
    ["!"] = " ",
    ["R"] = " ",
}

local icons = {
    ["typescript"] = "󰛦 ",
    ["python"] = " ",
    ["java"] = " ",
    ["html"] = " ",
    ["css"] = " ",
    ["scss"] = " ",
    ["javascript"] = "󰌞 ",
    ["javascriptreact"] = " ",
    ["markdown"] = " ",
    ["sh"] = " ",
    ["zsh"] = " ",
    ["vim"] = " ",
    ["rust"] = " ",
    ["cpp"] = " ",
    ["c"] = " ",
    ["go"] = " ",
    ["lua"] = " ",
    ["conf"] = " ",
    ["haskel"] = " ",
    ["ruby"] = " ",
    ["term"] = " ",
    ["txt"] = "󰈙 ",
    ["svelte"] = " ",
}

local function color()
    local mode = api.nvim_get_mode().mode
    local mode_color = "%#StatusLine#"
    if mode == "n" then
        mode_color = "%#StatusNormal#"
    elseif mode == "i" or mode == "ic" then
        mode_color = "%#StatusInsert#"
    elseif mode == "v" or mode == "V" or mode == "" then
        mode_color = "%#StatusVisual#"
    elseif mode == "R" then
        mode_color = "%#StatusReplace#"
    elseif mode == "c" then
        mode_color = "%#StatusCommand#"
    elseif mode == "t" then
        mode_color = "%#StatusTerminal#"
    end
    return mode_color
end

local function branch()
    local cmd = io.popen("git branch --show-current 2>/dev/null")
    if cmd then
        local curr_branch = cmd:read("*l") or cmd:read("*a")
        cmd:close()

        if curr_branch ~= "" then
            return string.format(" 󰊢  " .. curr_branch)
        else
            return ""
        end
    end
end

local function formatDiagnostic()
    local bufnr = vim.api.nvim_get_current_buf()
    local errorCount = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
    local warnCount = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
    local hintCount = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })

    local result = ""

    if errorCount > 0 then
        result = result .. " " .. errorCount .. " "
    end

    if warnCount > 0 then
        result = result .. " " .. warnCount .. " "
    end

    if hintCount > 0 then
        result = result .. " " .. hintCount .. " "
    end

    return result
end

-- StatusLine Modes
Status = function()
    return table.concat({
        color(), -- mode colors
        string.format("  %s ", modes[api.nvim_get_mode().mode]):upper(), -- mode
        "%#StatusActive#", -- middle color
        branch(),
        " ",
        formatDiagnostic(),
        "%=", -- right align
        string.format("%s", (icons[vim.bo.filetype] or "")),
        " %f ",
        color(), -- mode colors
        " %l:%c  ", -- line, column
    })
end

InactiveStatus = function()
    return table.concat({
        color(), -- mode colors
        "%#StatusActive#", -- middle color
        "%=", -- right align
        " %f ",
        color(), -- mode colors
    })
end

-- Execute statusline
autocmd({ "VimEnter" }, {
    pattern = "*",
    command = "set statusline=%!v:lua.Status()",
})

autocmd({ "BufEnter" }, {
    pattern = { "help", "startuptime", "qf", "lspinfo" },
    command = "setlocal statusline=%!v:lua.InactiveStatus()",
})
local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.TreeOpen, function()
    vim.cmd([[setlocal statusline=%!v:lua.InactiveStatus()]])
end)
