" leader + enter to reload configuration
nnoremap <silent> <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Better nav for omnicomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" ThePrimeagen remaps
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <Leader>= :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Move to previous/next
nnoremap <silent>    <A-,> :BufferLineCyclePrev<CR>
nnoremap <silent>    <A-.> :BufferLineCycleNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferLineMovePrev<CR>
nnoremap <silent>    <A->> :BufferLineMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferLineGoToBuffer 1<CR>
nnoremap <silent>    <A-2> :BufferLineGoToBuffer 2<CR>
nnoremap <silent>    <A-3> :BufferLineGoToBuffer 3<CR>
nnoremap <silent>    <A-4> :BufferLineGoToBuffer 4<CR>
nnoremap <silent>    <A-5> :BufferLineGoToBuffer 5<CR>
nnoremap <silent>    <A-6> :BufferLineGoToBuffer 6<CR>
nnoremap <silent>    <A-7> :BufferLineGoToBuffer 7<CR>
nnoremap <silent>    <A-8> :BufferLineGoToBuffer 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Close buffer
nnoremap <silent>    <A-w> :bdelete<CR>

nnoremap <silent> <C-p> :lua require'telescope.project'.project_files()<CR>

nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>gc <cmd>Telescope git_commits<CR>
nnoremap <leader>gb <cmd>Telescope git_branches<CR>
nnoremap <leader>gs <cmd>Telescope git_status<CR>

nnoremap <leader>gg <cmd>LazyGit<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

nnoremap <leader>fp :Neoformat<CR>

inoremap <c-v> <esc>:set paste<cr>a<c-r>=getreg('+')<cr><esc>:set nopaste<cr>mi`[=`]`ia

nnoremap <leader>sl <cmd>lua require("persistence").load()<CR>

" lsp
nnoremap <leader>er <cmd>Telescope diagnostics bufnr=0<CR>
nnoremap <leader>eR <cmd>Telescope diagnostics<CR>
nnoremap <leader>ss <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader>sd <cmd>Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap <leader>jl <cmd>Telescope jumplist<CR>
nnoremap <F2> <cmd>Lspsaga rename<CR>
nnoremap <leader>el <cmd>Lspsaga show_line_diagnostics<CR>
nnoremap <leader>lr <cmd>LspRestart<CR>

" harpoon
noremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent> <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent> <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent> <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent> <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent> <leader>5 :lua require("harpoon.ui").nav_file(5)<CR>
