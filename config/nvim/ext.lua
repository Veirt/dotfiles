require('lualine').setup {
  options = {theme = 'horizon'}
}

require'telescope'.load_extension('project')

require("presence"):setup({
    main_image          = "file",
    blacklist           = {},    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = false,
})
