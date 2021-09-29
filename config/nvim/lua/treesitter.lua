require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "rust", "javascript", "typescript", "lua", "fish", "bash", "latex", "dockerfile", 
    "cpp", "java", "json", "php", "toml", "vim", "vue", "yaml", "html", "css" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = false
    },
    autotag = {
        enable = true
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    }
}
