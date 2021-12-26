local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {},
}

local components = {
    active = { {}, {}, {} },
    inactive = { {}, {}, {} },
}

local colors = {
    black = "#2e313d",
    red = "#cf8164",
    green = "#76a065",
    yellow = "#ab924c",
    blue = "#8296b0",
    magenta = "#a18daf",
    cyan = "#659ea2",
    white = "#b5b4c9",
    fg = "#a89984",
    bg = "#1E2127",
}

local vi_mode_colors = {
    NORMAL = colors.green,
    OP = colors.green,
    INSERT = colors.red,
    VISUAL = colors.skyblue,
    BLOCK = colors.skyblue,
    REPLACE = colors.violet,
    ["V-REPLACE"] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow,
}

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == "UNIX" then
        icon = " "
    elseif os == "MAC" then
        icon = " "
    else
        icon = " "
    end
    return icon .. os
end

force_inactive.filetypes = {
    "NvimTree",
    "alpha",
    "dbui",
    "packer",
    "startify",
    "fugitive",
    "fugitiveblame",
    "help",
}

force_inactive.buftypes = {
    "terminal",
}

-- LEFT

-- vi-mode
components.active[1][1] = {
    provider = function()
        return string.format(" %s ", vi_mode_utils.get_vim_mode())
    end,
    hl = function()
        local val = {}

        val.bg = vi_mode_utils.get_mode_color()
        val.fg = colors.black
        val.style = "bold"

        return val
    end,
    right_sep = " ",
}

-- gitBranch
components.active[1][2] = {
    provider = "git_branch",
    hl = {
        fg = colors.green,
        bg = colors.bg,
        style = "bold",
    },
}

-- filename
components.active[1][3] = {
    provider = "file_info",
    hl = {
        fg = colors.white,
        bg = colors.bg,
        style = "bold",
    },
    left_sep = " ",
}

-- diagnosticErrors
components.active[1][4] = {
    provider = "diagnostic_errors",
    enabled = function()
        return lsp.diagnostics_exist("Error")
    end,
    hl = {
        fg = colors.red,
        style = "bold",
    },
    right_sep = " ",
}
-- diagnosticWarn
components.active[1][5] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist("Warn")
    end,
    hl = {
        fg = colors.yellow,
        style = "bold",
    },
    right_sep = " ",
}
-- diagnosticHint
components.active[1][6] = {
    provider = "diagnostic_hints",
    enabled = function()
        return lsp.diagnostics_exist("Hint")
    end,
    hl = {
        fg = "cyan",
        style = "bold",
    },
    right_sep = " ",
}
-- diagnosticInfo
components.active[1][7] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist("Info")
    end,
    hl = {
        fg = "skyblue",
        style = "bold",
    },
    right_sep = " ",
}

-- RIGHT

-- LspName
components.active[3][1] = {
    provider = "lsp_client_names",
    hl = {
        fg = colors.yellow,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}

-- diffAdd
components.active[3][2] = {
    provider = "git_diff_added",
    hl = {
        fg = colors.green,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}
-- diffModified
components.active[3][3] = {
    provider = "git_diff_changed",
    hl = {
        fg = colors.orange,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}
-- diffRemove
components.active[3][4] = {
    provider = "git_diff_removed",
    hl = {
        fg = colors.red,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}

-- fileEncode
components.active[3][5] = {
    provider = "file_encoding",
    hl = {
        fg = colors.white,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}
components.active[3][6] = {
    provider = file_osinfo,
    hl = {
        fg = colors.magenta,
        style = "bold",
    },
    right_sep = " ",
}
-- lineInfo
components.active[3][7] = {
    provider = "position",
    hl = {
        fg = colors.white,
        bg = colors.bg,
        style = "bold",
    },
    right_sep = " ",
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
    -- provider = 'file_type',
    provider = function()
        if vim.bo.filetype == "" then
            return string.format("NEW FILE", vim.bo.filetype)
        end
        return string.format("%s", vim.bo.filetype:upper())
    end,
    hl = {
        fg = colors.black,
        bg = colors.cyan,
        style = "bold",
    },
    left_sep = {
        str = " ",
        hl = {
            fg = "NONE",
            bg = colors.cyan,
        },
    },
    right_sep = {
        {
            str = " ",
            hl = {
                fg = "NONE",
                bg = colors.cyan,
            },
        },
        " ",
    },
}

require("feline").setup({
    colors = colors,
    default_bg = bg,
    default_fg = fg,
    vi_mode_colors = vi_mode_colors,
    components = components,
    force_inactive = force_inactive,
})
