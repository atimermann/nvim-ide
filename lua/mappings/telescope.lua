local map = vim.keymap.set
local welcomeWindow = require "welcome-window"

--------------------------------------------------------------------------------
-- Atalhos para o Telescope
-- TODO:    Todo
-- HACK:    HACK
-- PERF:    Perf
-- NOTE:    Note
-- FIX:     Fix
-- WARNING: WARNING
--------------------------------------------------------------------------------
local builtin = require "telescope.builtin"

map({ "n", "i", "v" }, "<A-f>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.find_files()
end, { desc = "Telescope encontrar arquivos" })

map({ "n", "i", "v" }, "<A-g>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.live_grep()
end, { desc = "Telescope pesquisa ao vivo" })

map({ "n", "i", "v" }, "<A-b>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.buffers()
end, { desc = "Telescope buffers" })

map({ "n", "i", "v" }, "<A-h>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.help_tags()
end, { desc = "Telescope ajuda" })

map({ "n", "i", "v" }, "<A-o>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.oldfiles()
end, { desc = "Telescope últimos arquivos" })
map({ "n", "i", "v" }, "<A-r>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção para executar o comando corretamente
  welcomeWindow.closeWelcomeWindow()
  vim.cmd "Telescope lsp_references"
end, { desc = "Telescope referências LSP" })

map({ "n", "i", "v" }, "<A-p>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção para executar o comando corretamente
  welcomeWindow.closeWelcomeWindow()

  -- Autocomando para reabrir o NvimTree quando o projeto for selecionado
  vim.api.nvim_create_autocmd("WinClosed", {
    once = true,
    callback = function()
      vim.defer_fn(function()
        vim.cmd "NvimTreeOpen"
      end, 250)
    end,
  })

  vim.cmd "NeovimProjectDiscover"
end, { desc = "Telescope histórico de projetos" })

-- Novo atalho: Alt + S para buscar símbolos no arquivo atual (incluindo funções)
map({ "n", "i", "v" }, "<A-s>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção para executar o comando corretamente
  welcomeWindow.closeWelcomeWindow()
  builtin.lsp_document_symbols()
end, { desc = "Telescope buscar funções no arquivo" })

map({ "n", "i", "v" }, "<A-t>", function()
  vim.cmd "stopinsert"
  welcomeWindow.closeWelcomeWindow()
  vim.cmd "TodoTelescope"
end, { desc = "Telescope referências LSP" })

---------------------------------------------------------------------------------
