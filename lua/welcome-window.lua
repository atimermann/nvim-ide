-- welcome_window.lua
local M = {}

local float_text = require "welcome"

-- Função para abrir a janela flutuante
function M.open_welcome_window()
  local buf = vim.api.nvim_create_buf(false, true)

  local width = 200
  local height = 50
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    border = "rounded",
  }
  -- Carregar o texto a partir do arquivo
  local content = float_text.get_text()

  -- Define o conteúdo da janela flutuante
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  -- Abre a janela flutuante
  vim.api.nvim_open_win(buf, true, opts)

  -- Atalhos para fechar a janela fechar a janela
  vim.api.nvim_buf_set_keymap(buf, "n", "<F2>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
end

return M
