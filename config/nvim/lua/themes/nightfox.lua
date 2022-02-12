local nightfox = require("nightfox")

nightfox.setup({
    fox = "nordfox",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = "italic",
        keywords = "bold",
        functions = "italic,bold",
    },
    inverse = {
        match_paren = true, -- inverse the highlighting of match_parens
    },
})

nightfox.load()
