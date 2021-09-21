require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "rust", "javascript", "typescript", "lua", "fish", "bash", "latex", "dockerfile", "graphql",
    "cpp", "jsdoc", "java", "json", "php", "toml", "vim", "yaml", "html", "css" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    },
}
