require('lualine').setup {
  options = {theme = 'tokyonight'}
}

require('nvim-autopairs').setup{}

require("bufferline").setup{}

require('gitsigns').setup()

require('which-key').setup {}

require'telescope'.load_extension('fzf')

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "rust", "javascript", "typescript", "lua", "fish", "bash", "dockerfile", "graphql",
    "cpp", "jsdoc", "java", "json", "php", "toml", "vim", "yaml", "html", "css" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },

}
