lua require('impatient')
lua require('plugins')

source $HOME/.config/nvim/modules/generals.vim
luafile $HOME/.config/nvim/lua/nvimtree.lua
source $HOME/.config/nvim/modules/remaps.vim
source $HOME/.config/nvim/modules/harpoon.vim
source $HOME/.config/nvim/modules/lsp.vim
luafile $HOME/.config/nvim/lua/dashboard.lua
luafile $HOME/.config/nvim/lua/init.lua
luafile $HOME/.config/nvim/lua/treesitter.lua
luafile $HOME/.config/nvim/lua/lsp.lua
luafile $HOME/.config/nvim/lua/lsp-utils.lua
luafile $HOME/.config/nvim/lua/lspsaga-config.lua
luafile $HOME/.config/nvim/lua/telescope-config.lua
luafile $HOME/.config/nvim/lua/statusline.lua
luafile $HOME/.config/nvim/lua/themes.lua

au FileType * set fo-=c fo-=r fo-=o

