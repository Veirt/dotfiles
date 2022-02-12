local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local force_inactive = {
    filetypes = {
        "NvimTree",
        "alpha",
        "dbui",
        "packer",
        "startify",
        "fugitive",
        "fugitiveblame",
        "help",
    },
    buftypes = {
        "terminal",
    },
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

-- reusable
local separator = {
    str = " ",
    hl = {
        bg = "NONE",
    },
}

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
    right_sep = separator,
}

-- gitBranch
components.active[1][2] = {
    provider = "git_branch",
    hl = {
        fg = colors.green,
        bg = "NONE",
        style = "bold",
    },
}

-- filename
components.active[1][3] = {
    provider = "file_info",
    hl = {
        fg = colors.white,
        bg = "NONE",
        style = "bold",
    },
    left_sep = separator,
}

-- diagnosticErrors
components.active[1][4] = {
    provider = "diagnostic_errors",
    enabled = function()
        return lsp.diagnostics_exist("Error")
    end,
    hl = {
        fg = colors.red,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- diagnosticWarn
components.active[1][5] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist("Warn")
    end,
    hl = {
        fg = colors.yellow,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- diagnosticHint
components.active[1][6] = {
    provider = "diagnostic_hints",
    enabled = function()
        return lsp.diagnostics_exist("Hint")
    end,
    hl = {
        fg = "cyan",
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- diagnosticInfo
components.active[1][7] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist("Info")
    end,
    hl = {
        fg = "skyblue",
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}

-- RIGHT

-- LspName
components.active[3][1] = {
    provider = "lsp_client_names",
    hl = {
        fg = colors.yellow,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}

-- diffAdd
components.active[3][2] = {
    provider = "git_diff_added",
    hl = {
        fg = colors.green,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- diffModified
components.active[3][3] = {
    provider = "git_diff_changed",
    hl = {
        fg = colors.orange,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- diffRemove
components.active[3][4] = {
    provider = "git_diff_removed",
    hl = {
        fg = colors.red,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}

-- fileEncode
components.active[3][5] = {
    provider = "file_encoding",
    hl = {
        fg = colors.white,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- osInfo
components.active[3][6] = {
    provider = file_osinfo,
    hl = {
        fg = colors.magenta,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}
-- lineInfo
components.active[3][7] = {
    provider = "position",
    hl = {
        fg = colors.white,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
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
            bg = colors.cyan,
        },
    },

    right_sep = {
        {
            str = " ",
            hl = {
                bg = colors.cyan,
            },
        },
        {
            str = " ",
            hl = {
                bg = "NONE",
            },
        },
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
