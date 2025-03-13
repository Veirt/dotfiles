local present, lspui = pcall(require, "LspUI")

if not present then
    return
end

lspui.setup({
    lightbulb = {
        icon = "󰌵",
    },
})
