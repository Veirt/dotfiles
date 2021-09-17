require('lualine').setup {
  options = {theme = 'tokyonight'}
}

require('nvim-autopairs').setup{}

require("trouble").setup{
    action_keys = {
        close = "<esc>",
    }
}

require('colorizer').setup{}

require("bufferline").setup{}

require('gitsigns').setup{}

require('which-key').setup {}


require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "rust", "javascript", "typescript", "lua", "fish", "bash", "dockerfile", "graphql",
    "cpp", "jsdoc", "java", "json", "php", "toml", "vim", "yaml", "html", "css" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = true
    }
}
