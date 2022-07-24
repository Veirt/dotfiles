local dap = require("dap")

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
    {
        name = "Launch",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
    },
}
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "green" })

cmd([[nnoremap <leader>dt <cmd>lua require('dap').toggle_breakpoint()<CR>]])
cmd([[nnoremap <leader>dk <cmd>lua require('dap').step_out()<CR>]])
cmd([[nnoremap <leader>dl <cmd>lua require('dap').step_into()<CR>]])
cmd([[nnoremap <leader>dj <cmd>lua require('dap').step_over()<CR>]])
cmd([[nnoremap <leader>dn <cmd>lua require('dap').continue()<CR>]])
cmd([[nnoremap <leader>d_ <cmd>lua require('dap').run_last()<CR>]])
cmd([[nnoremap <leader>dr <cmd>lua require('dap').repl.open({}, 'split')<CR>]])
cmd(
    [[nnoremap <leader>dh <cmd>lua require('dap.ui.variables').hover(function() return vim.fn.expand("<cexpr>") end)<CR>]]
)
cmd([[nnoremap <leader>da <cmd>lua require('nvim-dap').attach()<CR>]])

local function attach()
    print("Attaching debugger")
    dap.run({
        type = "node2",
        request = "attach",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**/*.js" },
    })
end

return {
    attach = attach,
}
