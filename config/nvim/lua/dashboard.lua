local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠌⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⠛⠿⣿⣇⣀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠉⠠⡄⠀⠀⠀⠈⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠰⠁⠉⠀⠀⠄",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⣠⢊⢵⢽⢄⠀⠀⠀⠀⠈⠙⠻⠿⣿⣿⣿⣿⡿⢟⠁⢀⠀⠀⠀⠀⡀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⢐⠇⠌⡠⡆⠀⠗⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡀⠀⠑⠠⠤⠒⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⣼⢴⠈⡔⣴⠀⢰⠀⢀⡑⠢⠄⢀⡀⠀⠀⠀⠀⠀⠀⣀⢇⣀⡀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣸⢸⡍⠘⣼⢸⠀⠘⣁⣘⠑⠀⣀⢼⠇⠈⡉⢉⣆⣈⡏⢰⡿⠟⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⢴⣶⣦⣷⠞⣚⣢⠆⠀⠀⠀⢈⣿⣿⣿⠂⠀⠀⠀⠘⣿⣿⡇⡇⢸⣿⠄⠂⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⠔⠉⢀⣿⡈⢀⠀⠀⠀⠀⡆⠸⣿⣿⣿⠀⠀⠀⠀⠸⣿⣿⡆⠣⢸⠈⢰⠀⢁⠀⠀⠀",
    "⠀⠀⠀⠀⢠⠊⠀⡰⠙⠿⠑⢄⡉⠀⠀⠀⢔⡀⠙⠛⠃⠠⠤⠤⠤⢄⠙⠛⠀⢠⢹⠀⠈⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⡌⠀⠀⡇⠀⠀⠀⠀⠈⠉⠲⠀⣧⣀⣀⣀⣀⣇⠀⠀⣀⣆⡀⠤⠒⢹⡄⠀⠇⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⡇⠀⠀⡧⠤⢀⡀⠀⠀⠀⢀⠥⢿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠸⠤⡜⠀⠀⠰⠀⠀⠀",
    "⠀⠀⢠⠊⢇⠀⠀⠘⢦⡀⠈⢢⠀⠀⠧⢄⡀⠀⠉⠉⠋⠛⠛⠋⠛⠁⠑⡔⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀",
    "⠀⠀⠇⠀⠸⠢⢄⡀⠀⠀⢀⠼⡀⢀⣠⣼⣿⣿⣿⣷⣶⣶⡒⠒⠲⣿⣯⡈⠠⠀⠀⠀⢐⠁⠘⠀⠀⠀",
    "⢀⠊⢆⠠⣄⣇⠀⠀⠉⠉⠀⠀⠈⠻⣿⡿⠿⠿⠿⠿⣿⣿⡇⠀⠀⢹⣿⣿⣷⣦⣀⣠⣂⠀⠀⠀⠀⠀",
    "⡇⠀⠈⠐⠓⠈⠀⠀⠀⠀⠀⠈⠑⢄⢱⠀⣀⣀⣀⣀⡈⣿⡇⠀⠀⠀⣿⣿⣿⣿⠿⠇⢌⠀⠀⠀⠀⠀",
    "⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣳⠉⢗⢫⣉⠐⠂⠱⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀",
    "⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠪⠊⠉⠹⠁⠀⠁⣏⣀⣀⣀⣀⣠⠤⠤⠔⠒⠒⠒⠉⠁⠀⠀⠀⠀",
    "⠀⠑⠢⢄⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡠⠔⠁⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

dashboard.section.buttons.val = {
    dashboard.button("SPC f n", "  New File", ":ene <BAR><CR>"),
    dashboard.button("SPC f o", "  Recents", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("SPC f g", "  Find Word", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("SPC f f", "  Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("SPC b m", "  Bookmarks", "<cmd>Telescope marks<CR>"),
}

dashboard.section.footer.val = { " " }

require("alpha").setup(require("alpha.themes.dashboard").opts)
