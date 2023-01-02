local present, dashboard = pcall(require, "alpha.themes.dashboard")

if not present then
    return
end

dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣴⠶⣶⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⡟⠛⢛⣲⣶⣾⣾⣯⣭⣴⣶⣾⡟⠀⠀⠈⠐⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣦⣴⠟⡽⠁⠀⢻⣆⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠈⠢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠊⠀⣼⠀⠀⠀⠀⠙⢧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢠⠁⠀⠀⣟⠀⠀⠀⠀⠀⠀⠉⠳⢄⠀⠀⠀⠀⠀⠀⠡⠀⠀⠠⡈⠢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⠀⠀⠃⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⢁⠀⠀⠙⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠜⡀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠏⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⡧⡀⠐⠄⠀⠀⠀⠘⡐⠱⣄⣽⣦⣄⢁⠀⠀⠀⢷⣄⠀⠀⠐⡀⡈⢄⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⣧⠑⠄⡀⠀⡀⠀⠀⠓⡪⠛⣹⣿⣿⡝⡖⠀⠀⣾⣿⠙⠂⠀⠙⡇⠀⡆⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢸⡄⠐⠀⠀⢻⡴⢛⢻⣶⠬⡖⠤⢬⡀⠀⢿⣿⣿⣧⠁⡀⢀⣿⣿⠀⠀⠠⡀⠅⡠⠁⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⢀⢾⣿⣄⣧⡀⠈⣷⠄⢻⣿⡇⠀⠀⠀⠀⠀⠀⠉⠩⣂⠄⠀⣼⣿⣿⣤⢀⢠⡍⠊⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢠⠃⠸⡇⠙⣿⣿⣶⣾⣧⡀⠉⠀⠀⠀⣠⡤⠀⠀⣀⣽⡇⢀⣼⣿⣿⣿⠻⠾⣈⠁⠵⠂⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠈⠄⡀⠩⠂⠌⢿⣿⡿⣿⣷⣶⣷⣶⣤⣴⣶⣶⣽⣿⣇⠱⡟⢿⡇⢿⣧⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠁⡇⡐⠁⢻⣿⣿⣏⣽⡟⣍⣉⣿⣷⡶⠻⢿⣿⠦⣿⣦⣌⡘⢿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⣠⣤⣶⣶⣷⣶⣾⡿⢿⣿⣷⣿⣭⠉⢉⠉⢛⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⣠⡿⣷⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣷⡵⣷⣲⣯⣿⣿⣿⣿⣿⣿⡿⠻⣿⣿⣿⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⢀⣼⡿⠿⠛⢛⣋⠉⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣾⢿⣿⠟⣡⣿⣿⣿⣿⡯⣧⠹⣿⣿⣾⣧⣀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠰⠖⢏⢿⣄⠀⠀⠈⠜⣿⣆⣀⣽⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡻⣷⡝⣯⣾⡯⣿⣽⢷⣦⣀⠀⢤⣐⡖",
    "⠀⡿⠟⠀⠗⠀⠀⠀⠀⠀⠈⠉⠈⠃⠀⠀⡰⣽⣿⣿⣉⡟⢿⣿⣿⡿⠿⣿⣏⠻⢽⣎⣿⣏⠹⣿⡯⡽⣆⣽⣴⣿⣿⡟⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣿⣧⣿⣿⣿⣿⣾⣷⣶⣶⣿⠇⠁⠪⣿⣟⣿⣵⣹⣿⣾⣿⡿⠿⠿⡟⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣰⣤⣎⣿⣿⣿⢿⣿⡝⢿⣿⡄⠀⢸⣷⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⡽⣿⣿⠟⣿⣿⣿⡇⠀⠋⠹⣿⣿⣿⣺⣶⠝⠃⠈⣿⣷⠀⢸⣹⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡿⠋⠀⢀⣿⣿⣿⠇⠠⠈⠒⠿⠟⠛⠘⢽⣇⠀⠀⡟⣿⣷⣸⡚⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⢀⣿⣿⡏⠂⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⢖⣇⠹⣿⣿⡁⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⢿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠢⡙⢿⡇⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

dashboard.section.buttons.val = {
    dashboard.button("<Space> fn", "  New", ":ene <BAR><CR>"),
    dashboard.button("<Space> fo", "  Recents", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("<Space> bm", "  Bookmarks", "<cmd>Telescope marks<CR>"),
    dashboard.button("<Space> sl", "ﴬ  Last", "<cmd>lua require('persisted').load()<CR>"),
}

require("alpha").setup(dashboard.opts)
