require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "help",
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "html",
        "javascript",
        "jsonc",
        "lua",
        "php",
        "prisma",
        "python",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
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