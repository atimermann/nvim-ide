
local M = {}
local floatText = require "welcome"

-- Variáveis para armazenar o ID do buffer e da janela
local winId = nil
local bufId = nil

-- Função para abrir a janela flutuante
function M.openWelcomeWindow()
  -- Cria o buffer apenas se ele ainda não existir
  bufId = vim.api.nvim_create_buf(false, true)

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
  local content = floatText.get_text()

  -- Define o conteúdo da janela flutuante
  vim.api.nvim_buf_set_lines(bufId, 0, -1, false, content)

  -- Abre a janela flutuante e armazena o ID
  winId = vim.api.nvim_open_win(bufId, true, opts)

  -- Atalhos para fechar a janela
  vim.api.nvim_buf_set_keymap(bufId, "n", "<F2>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufId, "n", "<Esc>", "<Cmd>bd!<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufId, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
end

-- Função para fechar a janela flutuante
function M.closeWelcomeWindow()
  if winId and vim.api.nvim_win_is_valid(winId) then
    vim.api.nvim_win_close(winId, true)
  end
end

return M
