require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Salva em qualquer momento
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Map Alt + 1 para abrir o diretório de configuração do Neovim
map("n", "<A-1>", ":cd ~/.config/nvim/<CR>", { noremap = true, silent = true })
map("n", "<A-0>", ":cd -<CR>", { noremap = true, silent = true })

-- Salva Sessão, salva arquivos abertos e sai
map({ "n", "i", "v" }, "<C-q><C-q>", ":wa<CR>:qa<CR>", { desc = "Save session, save all and quit", silent = true })

-- Formatar arquivo atual
-- map({ "n", "i" }, "<C-k>", function() vim.lsp.buf.format() end, { desc = "Format current file", silent = true })
map({ "n", "i" }, "<C-k>", function()
  require("conform").format { async = true }
end, { desc = "Format current file", silent = false })

-- Mapeamento para Ctrl+Tab trocar de aba (buffer) no modo normal e de inserção
map({ "n", "i" }, "<C-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- Atalho para comentar no modo edição e visual. (Veja documentação com :h comment.api)
local commentApi = require "Comment.api"
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

map({ "n", "i" }, "<C-;>", commentApi.toggle.linewise.current)

map("x", "<C-;>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  commentApi.toggle.linewise(vim.fn.visualmode())
end)

-- TODO: Revisar
map("x", "<C-;>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  commentApi.toggle.blockwise(vim.fn.visualmode())
end)

-- Move between windows with Alt + arrow keys
vim.api.nvim_set_keymap("n", "<A-Left>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Right>", "<C-w>l", { noremap = true, silent = true })

-- Depuração
map("n", "<F5>", function()
  require("dap").continue()
end, { noremap = true, silent = false })
map("n", "<F6>", function()
  require("dapui").toggle()
end, { noremap = true, silent = true })
map("n", "<F7>", function()
  require("dap").toggle_breakpoint()
end, { noremap = true, silent = true })
map("n", "<F10>", function()
  require("dap").step_over()
end, { noremap = true, silent = true })
map("n", "<F11>", function()
  require("dap").step_into()
end, { noremap = true, silent = true })
map("n", "<F12>", function()
  require("dap").step_out()
end, { noremap = true, silent = true })

-- Atalhos para o Telescope
local builtin = require "telescope.builtin"

map("n", "<A-f>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<A-g>", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<A-b>", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<A-h>", builtin.help_tags, { desc = "Telescope help tags" })

map({ "n", "i" }, "<A-r>", ":Glow<CR>", { noremap = true, silent = true, desc = "Render Markdown with Glow" })

--------------------------------------------------------------------------
-- TELA DE BOAS VINDAS
--------------------------------------------------------------------------

-- Mapeamento da tecla F2
map("n", "<F2>", function()
  local welcome_window = require "welcome-window"
  welcome_window.open_welcome_window()
end, { noremap = true, silent = true })
