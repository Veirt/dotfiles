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
        show_buffer_close_icons = false,
        show_close_icon = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }

  }
}

require('gitsigns').setup{}

require('which-key').setup {}

require("presence"):setup({
  -- Oh gosh i'm fucking evil
  -- Sometimes my genius is almost frightening
  buttons = { { label="Guess what it is.", url="https://www.youtube.com/watch?v=dQw4w9WgXcQ" } } 
})
