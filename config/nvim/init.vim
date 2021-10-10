source $HOME/.config/nvim/modules/generals.vim
source $HOME/.config/nvim/modules/plugins.vim
" source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/coq.vim
" source $HOME/.config/nvim/modules/nerdtree.vim
luafile $HOME/.config/nvim/lua/nvimtree.lua
source $HOME/.config/nvim/modules/remaps.vim
source $HOME/.config/nvim/modules/harpoon.vim
source $HOME/.config/nvim/modules/lsp.vim
luafile $HOME/.config/nvim/lua/dashboard.lua
luafile $HOME/.config/nvim/lua/init.lua
" luafile $HOME/.config/nvim/lua/autopairs.lua
luafile $HOME/.config/nvim/lua/treesitter.lua
luafile $HOME/.config/nvim/lua/lsp.lua
luafile $HOME/.config/nvim/lua/lspsaga-config.lua
luafile $HOME/.config/nvim/lua/telescope-config.lua
luafile $HOME/.config/nvim/lua/statusline.lua
luafile $HOME/.config/nvim/lua/themes.lua

au FileType * set fo-=c fo-=r fo-=o

