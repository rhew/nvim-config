-- TODO convert to pure LUA

-- Base dap keymaps
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>ds", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

-- hover in a floating window. I like dapui.eval() better
-- vim.keymap.set("n", "<leader>dh", ":lua require'dap.ui.widgets'.hover()<CR>")

require("dap-go").setup()
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

require("dapui").setup()
vim.keymap.set("n", "<leader>du", ":lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>dh", ":lua require('dapui').eval()<CR>")

require("nvim-dap-virtual-text").setup()

require("telescope").load_extension("dap")
