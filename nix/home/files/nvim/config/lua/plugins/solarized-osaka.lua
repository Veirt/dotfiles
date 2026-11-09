return {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("solarized-osaka").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            transparent = true, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { bold = true, italic = true },
                functions = { bold = true },
                variables = { bold = true },
                sidebars = "transparent",
                floats = "transparent",
            },
            sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false, -- dims inactive windows
            lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
        })
        vim.cmd([[colorscheme solarized-osaka]])
        vim.cmd([[hi CursorLine guibg=#1F1F1F]])
        vim.cmd([[hi TabLineFill guibg=NONE]])
        vim.cmd([[hi PMenu guibg=#1F1F1F]])
        vim.cmd([[hi LineNr guibg=NONE ctermbg=NONE guifg=#fff]])
        vim.cmd([[hi CursorLineNr guifg=#fefefe]])
        vim.cmd([[hi NvimTreeNormal guibg=NONE]])
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "󰌵",
                    [vim.diagnostic.severity.HINT] = "",
                },
            },
        })
    end,
}
