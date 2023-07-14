local utils = require("utils")

-- General
utils.map("n", "<C-s>", ":w<CR>")
utils.map("i", "<C-s>", "<C-O>:update<CR>")
utils.map("n", "<C-Q>", ":wq!<CR>")
utils.map("v", "<C-c>", '"+y')
utils.map("i", "<C-v>", "<esc>:set paste<cr>a<c-r>=getreg('+')<cr><esc>:set nopaste<cr>mi`[=`]`ia")
utils.map("n", "<leader>x", "<cmd>!chmod +x %<CR>")
utils.map("n", "<leader>wq", "<cmd>wq<CR>")

-- ThePrimeagen's remaps
utils.map("n", "Y", "yg$")
utils.map("n", "n", "nzzzv")
utils.map("n", "N", "Nzzzv")
utils.map("n", "J", "mzJ`z")
utils.map("n", "<leader>y", '"+y')
utils.map("v", "<leader>y", '"+y')
utils.map("n", "<leader>Y", 'gg"+yG')

-- Window
utils.map("n", "<leader>=", "<cmd>vertical resize +5<CR>")
utils.map("n", "<leader>-", "<cmd>vertical resize -5<CR>")

-- Buffer
utils.map("n", "<A-w>", ":bdelete<CR>")
utils.map("n", "<A-W>", ":bdelete!<CR>")

utils.map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>")
utils.map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>")
utils.map("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>")
utils.map("n", "<A->>", "<cmd>BufferLineMoveNext<CR>")

utils.map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
utils.map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
utils.map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
utils.map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
utils.map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
utils.map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
utils.map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
utils.map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
utils.map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")

-- Telescope
utils.map("n", "<C-p>", "<cmd>lua require('telescope.project').project_files()<CR>")
utils.map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
utils.map("n", "<leader>jl", "<cmd>Telescope jumplist<CR>")
utils.map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
utils.map("n", "<leader>sf", "<cmd> lua require('telescope.builtin').find_files()<CR>")

-- Navigator.nvim
utils.map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>")
utils.map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>")
utils.map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>")
utils.map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>")

-- refactoring.nvim
utils.map("n", "<leader>rp", "<cmd>lua require('refactoring').debug.printf({below = false})<CR>")
utils.map("v", "<leader>rv", "<cmd>lua require('refactoring').debug.print_var({})<CR>")
utils.map("n", "<leader>rc", "<cmd>lua require('refactoring').debug.cleanup({})<CR>")

-- Nvimtree
utils.map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")

-- Session
utils.map("n", "<leader>sl", [[<cmd>lua require("persisted").load()<cr>]])

-- Git
utils.map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
utils.map("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
utils.map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
utils.map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
utils.map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>")
utils.map("n", "<leader>sh", "<cmd>Gitsigns stage_hunk<CR>")
utils.map("n", "<leader>gg", "<cmd>LazyGit<CR>")
utils.map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
utils.map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
utils.map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")

-- Harpoon
utils.map("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>")
utils.map("n", "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
utils.map("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
utils.map("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
utils.map("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
utils.map("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
utils.map("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")
utils.map("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>")

-- Copilot
utils.map("n", "<leader>cpe", "<cmd>Copilot! attach<CR> <cmd>lua print('Copilot attached')<CR>")
utils.map("n", "<leader>cpd", "<cmd>Copilot! detach<CR> <cmd>lua print('Copilot detached')<CR>")

-- Formatting
utils.map("n", "<leader>df", "<cmd>lua ToggleFormatting()<CR>")
