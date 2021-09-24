require('lualine').setup {
  extensions = {'fugitive', 'nvim-tree'},
  options = {
    theme = 'tokyonight',
    disabled_filetypes = {'dashboard'},
    section_separators = {'', ''},
    component_separators = {'|', '|'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {''},
    lualine_x = {''},
    lualine_y = {'branch','encoding'},
    lualine_z = {'location'}
  },

}

require('nvim-autopairs').setup{}

require("trouble").setup{
  action_keys = {
    close = "<esc>",
  }
}

require('colorizer').setup()

require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false
  }
}

require('gitsigns').setup{}

require('which-key').setup {}

require("presence"):setup({
  -- Oh gosh i'm fucking evil
  -- Sometimes my genius is almost frightening
  buttons = { { label="Guess what it is.", url="https://www.youtube.com/watch?v=dQw4w9WgXcQ" } } 
})
