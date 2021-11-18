source $HOME/.config/nvim/modules/generals.vim
source $HOME/.config/nvim/modules/remaps.vim

lua require('impatient')
lua require('plugins')

lua require('init')
lua require('nvimtree')
lua require('dashboard')
lua require('statusline')
lua require('themes')
lua require('treesitter')
lua require('lsp')
lua require('lsp.utils')
lua require('lsp.lspsaga')
lua require('telescope.config')
lua require('nvim-cmp')

autocmd BufNewFile,BufRead,FileType,OptionSet * set formatoptions-=cro
