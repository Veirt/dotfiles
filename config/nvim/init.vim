lua require('impatient')
lua require('plugins')

source $HOME/.config/nvim/modules/generals.vim
source $HOME/.config/nvim/modules/remaps.vim
luafile $HOME/.config/nvim/lua/nvimtree.lua
luafile $HOME/.config/nvim/lua/dashboard.lua
luafile $HOME/.config/nvim/lua/themes.lua
luafile $HOME/.config/nvim/lua/init.lua
luafile $HOME/.config/nvim/lua/treesitter.lua
luafile $HOME/.config/nvim/lua/lsp.lua
luafile $HOME/.config/nvim/lua/nvim-cmp.lua
luafile $HOME/.config/nvim/lua/lsp-utils.lua
luafile $HOME/.config/nvim/lua/lspsaga-config.lua
luafile $HOME/.config/nvim/lua/telescope-config.lua
luafile $HOME/.config/nvim/lua/statusline.lua

autocmd! FileType * set fo-=c fo-=r fo-=o

