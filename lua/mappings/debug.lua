local map = vim.keymap.set

-- Depuração
map("n", "<F5>", function()
  require("dap").continue()
end, { noremap = true, silent = false, desc = "Iniciar depurador / continuar" })
map("n", "<F6>", function()
  require("dapui").toggle()
end, { noremap = true, silent = true, desc = "Alternar interface de depuração" })
map("n", "<F7>", function()
  require("dap").toggle_breakpoint()
end, { noremap = true, silent = true, desc = "Alternar breakpoint" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { noremap = true, silent = true, desc = "Step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { noremap = true, silent = true, desc = "Step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { noremap = true, silent = true, desc = "Step out" })

