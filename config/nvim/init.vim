source $HOME/.config/nvim/modules/generals.vim

lua require('impatient')
lua require('packer_compiled')
lua require('plugins')

lua require('remaps')
lua require('session')
lua require('filetype-nvim')
lua require('nvimtree')
lua require('dashboard')
lua require('statusline')
lua require('themes')
lua require('treesitter')
lua require('refactoring-nvim')
lua require('lsp')
lua require('lsp.tsutils')
lua require('lsp.lspsaga')
lua require('telescope.custom')
lua require('nvim-comment')
lua require('nvim-cmp')
" lua require('nvim-dap')
lua require('others')

" absolutely disable continuous comment frfr no cap.
au! BufEnter * set fo-=c fo-=r fo-=o
