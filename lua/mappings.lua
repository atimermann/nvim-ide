require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Salva em qualquer momento
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Salva Sessão, salva arquivos abertos e sai
map("n", "<C-q><C-q>", ":wa<CR>:qa<CR>", { desc = "Save session, save all and quit", silent = true })

-- Formatar arquivo atual
map({ "n", "i" }, "<C-k>", function() vim.lsp.buf.format() end, { desc = "Format current file", silent = true })

-- Mapeamento para Ctrl+Tab trocar de aba (buffer) no modo normal e de inserção
map({ "n", "i" }, "<C-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- Atalho para comentar no modo edição e visual. (Veja documentação com :h comment.api)
local commentApi = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set({ "n", "i" }, '<C-_>', commentApi.toggle.linewise.current)

vim.keymap.set('x', '<C-_>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  commentApi.toggle.linewise(vim.fn.visualmode())
end)

-- TODO: Revisar
vim.keymap.set('x', '<leader>b', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  commentApi.toggle.blockwise(vim.fn.visualmode())
end)

