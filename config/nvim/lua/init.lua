require('nvim-autopairs').setup{}

require("trouble").setup{
  action_keys = {
    close = "<esc>",
  }
}

require('colorizer').setup()

require('gitsigns').setup{}

-- require('which-key').setup {}

require("presence"):setup({
  -- Oh gosh i'm fucking evil
  -- Sometimes my genius is almost frightening
  buttons = { { label="Guess what it is.", url="https://www.youtube.com/watch?v=dQw4w9WgXcQ" } } 
})
