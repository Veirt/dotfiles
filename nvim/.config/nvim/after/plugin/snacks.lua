local present, snacks = pcall(require, "snacks")

if not present then
    return
end

snacks.setup({
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = {
        enabled = true,
        theme = {
            activeBorderColor = { fg = "Keyword" },
            inactiveBorderColor = { fg = "Normal" },
        },
    },
})
