source $HOME/.config/nvim/modules/generals.vim
source $HOME/.config/nvim/modules/remaps.vim

lua require('impatient')
lua require('plugins')
lua require('packer_compiled')

lua require('init')
lua require('filetype-nvim')
lua require('nvimtree')
lua require('dashboard')
lua require('statusline')
lua require('nvim-comment')
lua require('themes')
lua require('treesitter')
lua require('refactoring-nvim')
lua require('lsp')
lua require('lsp.tsutils')
lua require('lsp.lspsaga')
lua require('telescope.custom')
lua require('nvim-cmp')

autocmd! BufNewFile,BufRead,FileType,OptionSet * set formatoptions-=cro
