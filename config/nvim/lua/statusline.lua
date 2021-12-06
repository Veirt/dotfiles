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
    NORMAL = "green",
    OP = "green",
    INSERT = "red",
    VISUAL = "skyblue",
    BLOCK = "skyblue",
    REPLACE = "violet",
    ["V-REPLACE"] = "violet",
    ENTER = "cyan",
    MORE = "cyan",
    SELECT = "orange",
    COMMAND = "green",
    SHELL = "green",
    TERM = "green",
    NONE = "yellow",
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
        val.fg = "black"
        val.style = "bold"

        return val
    end,
    right_sep = " ",
}
-- gitBranch
components.active[1][2] = {
    provider = "git_branch",
    hl = {
        fg = "yellow",
        bg = "bg",
        style = "bold",
    },
}
-- filename
components.active[1][3] = {
    provider = function()
        return vim.fn.expand("%:F")
    end,
    hl = {
        fg = "white",
        bg = "bg",
        style = "bold",
    },
    left_sep = " ",
}
-- diffAdd
components.active[1][4] = {
    provider = "git_diff_added",
    hl = {
        fg = "green",
        bg = "bg",
        style = "bold",
    },
}
-- diffModified
components.active[1][5] = {
    provider = "git_diff_changed",
    hl = {
        fg = "orange",
        bg = "bg",
        style = "bold",
    },
}
-- diffRemove
components.active[1][6] = {
    provider = "git_diff_removed",
    hl = {
        fg = "red",
        bg = "bg",
        style = "bold",
    },
}

-- RIGHT

-- diagnosticErrors
components.active[3][1] = {
    provider = "diagnostic_errors",
    enabled = function()
        return lsp.diagnostics_exist("Error")
    end,
    hl = {
        fg = "red",
        style = "bold",
    },
    right_sep = " ",
}
-- diagnosticWarn
components.active[3][2] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist("Warning")
    end,
    hl = {
        fg = "yellow",
        style = "bold",
    },
    right_sep = " ",
}
-- diagnosticHint
components.active[3][3] = {
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
components.active[3][4] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist("Information")
    end,
    hl = {
        fg = "skyblue",
        style = "bold",
    },
    right_sep = " ",
}

-- LspName
components.active[3][5] = {
    provider = "lsp_client_names",
    hl = {
        fg = "yellow",
        bg = "bg",
        style = "bold",
    },
    right_sep = " ",
}

-- fileIcon
components.active[3][6] = {
    provider = function()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon = require("nvim-web-devicons").get_icon(filename, extension)
        if icon == nil then
            icon = ""
        end
        return icon
    end,
    hl = function()
        local val = {}
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon, name = require("nvim-web-devicons").get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), "fg")
        else
            val.fg = "white"
        end
        val.bg = "bg"
        val.style = "bold"
        return val
    end,
    right_sep = " ",
}
-- fileType
components.active[3][7] = {
    provider = "file_type",
    hl = function()
        local val = {}
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon, name = require("nvim-web-devicons").get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), "fg")
        else
            val.fg = "white"
        end
        val.bg = "bg"
        val.style = "bold"
        return val
    end,
    right_sep = " ",
}
-- fileFormat
-- components.active[3][4] = {
--   provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
-- fileEncode
components.active[3][8] = {
    provider = "file_encoding",
    hl = {
        fg = "white",
        bg = "bg",
        style = "bold",
    },
    right_sep = " ",
}
-- lineInfo
components.active[3][9] = {
    provider = "position",
    hl = {
        fg = "white",
        bg = "bg",
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
        fg = "black",
        bg = "cyan",
        style = "bold",
    },
    left_sep = {
        str = " ",
        hl = {
            fg = "NONE",
            bg = "cyan",
        },
    },
    right_sep = {
        {
            str = " ",
            hl = {
                fg = "NONE",
                bg = "cyan",
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
