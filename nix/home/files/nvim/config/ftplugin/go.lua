local utils = require("utils")

utils.map("n", "<leader>gtj", "<cmd>GoTagAdd json<CR>")
utils.map("n", "<leader>gtb", "<cmd>GoTagAdd bson<CR>")
