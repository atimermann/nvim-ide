local M = {}
local float_text = require "welcome"

-- Variáveis para armazenar o ID do buffer e da janela
local win_id = nil
local buf_id = nil

-- Função para abrir a janela flutuante
function M.open_welcome_window()
  -- Cria o buffer apenas se ele ainda não existir
  buf_id = vim.api.nvim_create_buf(false, true)

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
  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, content)

  -- Abre a janela flutuante e armazena o ID
  win_id = vim.api.nvim_open_win(buf_id, true, opts)

  -- Atalhos para fechar a janela
  vim.api.nvim_buf_set_keymap(buf_id, "n", "<F2>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf_id, "n", "<Esc>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf_id, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
end

-- Função para fechar a janela flutuante
function M.close_welcome_window()
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, true)
  end
end

return M
