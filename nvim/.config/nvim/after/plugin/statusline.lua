local custom_iceberg = require("lualine.themes.iceberg_dark")

local color = { fg = "#ffffff", bg = "#151515" }
custom_iceberg.normal.c.bg = "#151515"

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = custom_iceberg,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                icon = "",
                color = color,
            },
        },
        lualine_b = { { "branch", icon = "󰊢 ", color = color }, "diagnostics" },
        lualine_c = {},
        lualine_x = { { "filetype", colored = false, icon_only = true }, { "filename", path = 1, color = color } },
        lualine_y = {},
        lualine_z = { { "location", color = color } },
    },
})
