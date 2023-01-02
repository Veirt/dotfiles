local present, _ = pcall(require, "feline")

if not present then
    return
end

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
}

local components = {
    active = { {}, {}, {} },
    inactive = { {}, {}, {} },
}

local colors = {
    fg = "#D0D0D0",
    bg = "#151515",
    black = "#424242",
    skyblue = "#8DA3B9",
    cyan = "#8AA6A2",
    green = "#8C977D",
    oceanblue = "#8DA3B9",
    magenta = "#A988B0",
    orange = "#D9BC8C",
    red = "#B66467",
    violet = "#A988B0",
    white = "#E8E3E3",
    yellow = "#D9BC8C",
}

-- reusable
local separator = {
    str = " ",
    hl = {
        bg = "NONE",
    },
}

-- LEFT

-- vi-mode
components.active[1][1] = {
    provider = function()
        return string.format(" %s ", vi_mode_utils.get_vim_mode())
    end,
    hl = function()
        local val = {
            bg = vi_mode_utils.get_mode_color(),
            fg = colors.black,
            style = "bold",
        }

        return val
    end,
    right_sep = separator,
}

-- gitBranch
components.active[1][2] = {
    provider = "git_branch",
    hl = {
        fg = colors.white,
        bg = "NONE",
    },
}

-- diffAdd
components.active[1][3] = {
    provider = "git_diff_added",
    hl = {
        fg = colors.green,
        bg = "NONE",
    },
}
-- diffModified
components.active[1][4] = {
    provider = "git_diff_changed",
    hl = {
        fg = colors.yellow,
        bg = "NONE",
    },
}
-- diffRemove
components.active[1][5] = {
    provider = "git_diff_removed",
    hl = {
        fg = colors.red,
        bg = "NONE",
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
        fg = colors.red,
        bg = "NONE",
    },
    right_sep = separator,
}
-- diagnosticWarn
components.active[3][2] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist("Warn")
    end,
    hl = {
        fg = colors.yellow,
        bg = "NONE",
    },
    right_sep = separator,
}
-- diagnosticHint
components.active[3][3] = {
    provider = "diagnostic_hints",
    enabled = function()
        return lsp.diagnostics_exist("Hint")
    end,
    hl = {
        fg = "cyan",
        bg = "NONE",
    },
    right_sep = separator,
}
-- diagnosticInfo
components.active[3][4] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist("Info")
    end,
    hl = {
        fg = "skyblue",
        bg = "NONE",
    },
    right_sep = separator,
}

-- fileName
components.active[3][5] = {
    provider = {
        name = "file_info",
        opts = {
            file_readonly_icon = "",
            type = "relative",
        },
    },
    hl = {
        fg = colors.white,
        bg = "NONE",
        style = "bold",
    },
    right_sep = separator,
}

-- lineInfo
components.active[3][6] = {
    provider = "position",
    hl = {
        fg = colors.white,
        bg = "NONE",
    },
    right_sep = separator,
}

-- INACTIVE

require("feline").setup({
    components = components,
    force_inactive = force_inactive,
})
