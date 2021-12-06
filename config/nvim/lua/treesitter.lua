local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.prisma = {
    install_info = {
        url = "https://github.com/richin13/tree-sitter-prisma.git", -- temporarily :D
        files = { "src/parser.c" },
    },
    filetype = "prisma",
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "python",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "fish",
        "bash",
        "latex",
        "dockerfile",
        "cpp",
        "java",
        "jsonc",
        "php",
        "toml",
        "vim",
        "vue",
        "yaml",
        "html",
        "css",
        "scss",
        "java",
        "c",
        "cpp",
        "cmake",
        "c_sharp",
        "prisma",
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = false,
    },
    autotag = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    context_commentstring = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    textobjects = {
        enable = true,
    },
})
