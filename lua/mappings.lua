require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local welcomeWindow = require "welcome-window"

map("n", ";", ":", { desc = "Entrar no modo de comando" })

-- Salva em qualquer momento
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Salvar arquivo" })

-- Map Alt + 1 para abrir o diretório de configuração do Neovim
map(
  "n",
  "<A-1>",
  ":cd ~/.config/nvim/<CR>",
  { noremap = true, silent = true, desc = "Abrir diretório de configuração do Neovim" }
)
map("n", "<A-0>", ":cd -<CR>", { noremap = true, silent = true, desc = "Voltar ao diretório anterior" })

-- Salva Sessão, salva arquivos abertos e sai
map({ "n", "i", "v" }, "<C-q><C-q>", ":wa<CR>:qa<CR>", { desc = "Salvar sessão, salvar tudo e sair", silent = true })

-- Formatar arquivo atual
map({ "n", "i" }, "<C-k>", function()
  require("conform").format { async = true }
end, { desc = "Formatar arquivo atual", silent = false })

-- Mapeamento para Ctrl+Tab trocar de aba (buffer) no modo normal e de inserção
map({ "n", "i" }, "<C-l>", ":bnext<CR>", { desc = "Próximo buffer", silent = true })

-- Atalho para comentar no modo edição e visual. (Veja documentação com :h comment.api)
local commentApi = require "Comment.api"
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

map({ "n", "i" }, "<C-;>", commentApi.toggle.linewise.current, { desc = "Comentar/descomentar linha atual" })

map("x", "<C-;>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  commentApi.toggle.linewise(vim.fn.visualmode())
end, { desc = "Comentar/descomentar linha(s) selecionada(s)" })

-- TODO: Revisar
map("x", "<C-;>", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  commentApi.toggle.blockwise(vim.fn.visualmode())
end, { desc = "Comentar/descomentar bloco selecionado" })

-- Move between windows with Alt + arrow keys
vim.api.nvim_set_keymap("n", "<A-Left>", "<C-w>h", { silent = true, desc = "Mover para janela à esquerda" })
vim.api.nvim_set_keymap("n", "<A-Down>", "<C-w>j", { noremap = true, silent = true, desc = "Mover para janela abaixo" })
vim.api.nvim_set_keymap("n", "<A-Up>", "<C-w>k", { noremap = true, silent = true, desc = "Mover para janela acima" })
vim.api.nvim_set_keymap(
  "n",
  "<A-Right>",
  "<C-w>l",
  { noremap = true, silent = true, desc = "Mover para janela à direita" }
)

-- Depuração
map("n", "<F5>", function()
  require("dap").continue()
end, { noremap = true, silent = false, desc = "Inicia Depurador / continue" })
map("n", "<F6>", function()
  require("dapui").toggle()
end, { noremap = true, silent = true, desc = "Interface de depuração" })
map("n", "<F7>", function()
  require("dap").toggle_breakpoint()
end, { noremap = true, silent = true, desc = "Alternar breakpoint" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { noremap = true, silent = true, desc = "step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { noremap = true, silent = true, desc = "step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { noremap = true, silent = true, desc = "step out" })

--------------------------------------------------------------------------------
-- Atalhos para o Telescope
--------------------------------------------------------------------------------
local builtin = require "telescope.builtin"

map("n", "<A-f>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.find_files()
end, { desc = "Telescope encontrar arquivos" })

map("n", "<A-g>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.live_grep()
end, { desc = "Telescope pesquisa ao vivo" })

map("n", "<A-b>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.buffers()
end, { desc = "Telescope buffers" })

map("n", "<A-h>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.help_tags()
end, { desc = "Telescope ajuda" })

map("n", "<A-o>", function()
  welcomeWindow.closeWelcomeWindow()
  builtin.oldfiles()
end, { desc = "Telescope ultimos arquivos" })

map({ "n", "i", "v" }, "<A-r>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção para executar o comando corretamente
  welcomeWindow.closeWelcomeWindow()
  vim.cmd "Telescope lsp_references"
end, opts)

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

  vim.cmd "NeovimProjectHistory"
end, opts)

---------------------------------------------------------------------------------

-- Mapear Alt+D para Go to Definition no modo normal, visual e inserção
map({ "n", "i", "v" }, "<A-d>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção, se necessário
  vim.lsp.buf.definition() -- Vai para a definição
end, opts)

-- Mapear Alt+I para Go to Implementation no modo normal, visual e inserção
map({ "n", "i", "v" }, "<A-i>", function()
  vim.cmd "stopinsert" -- Sai do modo de inserção, se necessário
  vim.lsp.buf.implementation() -- Vai para a implementação
end, opts)

-- Renderização
map({ "n", "i" }, "<A-r><A-g>", ":Glow<CR>", { noremap = true, silent = true, desc = "Renderizar Markdown com Glow" })

-- Adicionar as teclas para navegação de posição de cursor no mappings.lua
map("n", "<C-A-Left>", "<C-o>", { noremap = true, silent = true, desc = "Voltar para posição anterior do cursor" })
map("n", "<C-A-Right>", "<C-i>", { noremap = true, silent = true, desc = "Avançar para próxima posição do cursor" })

-- Mapeamento para ir para a posição anterior no modo de inserção e voltar ao modo de inserção
map(
  "i",
  "<C-A-Left>",
  "<C-o><C-o>i",
  { noremap = true, silent = true, desc = "Voltar para posição anterior no modo de inserção" }
)
-- Mapeamento para ir para a próxima posição no modo de inserção e voltar ao modo de inserção
map(
  "i",
  "<C-A-Right>",
  "<C-o><C-i>i",
  { noremap = true, silent = true, desc = "Avançar para próxima posição no modo de inserção" }
)

-- Navegação entre blocos (t)
map("n", "<C-A-Up>", "[m", { noremap = true, silent = true, desc = "Navegar para bloco anterior" })
map("n", "<C-A-Down>", "]m", { noremap = true, silent = true, desc = "Navegar para próximo bloco" })

-- Ajuda com comandos
map("n", "<C-A-h>", ":WhichKey<CR>", { noremap = true, desc = "Abrir WhichKey" })

-- Mapeia Ctrl+C para copiar a seleção visual para o clipboard do sistema
map(
  "v",
  "<C-c>",
  '"+y',
  { noremap = true, silent = true, desc = "Copiar seleção visual para o clipboard do sistema" }
)

-- Mapeia Ctrl+V para colar o conteúdo do clipboard do sistema no modo normal, inserção e visual
map("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Colar do clipboard no modo normal" })
map("i", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Colar do clipboard no modo de inserção" })
map("v", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Colar do clipboard no modo visual" })

-- Mapeia Ctrl+Alt+C para copiar o nome do arquivo atual para o clipboard do sistema em todos os modos
vim.keymap.set(
  "n",
  "<C-A-c>",
  ":let @+ = expand('%')<CR>",
  { noremap = true, silent = false, desc = "Copiar nome do arquivo atual para o clipboard" }
)
vim.keymap.set(
  "i",
  "<C-A-c>",
  "<C-o>:let @+ = expand('%')<CR>",
  { noremap = true, silent = false, desc = "Copiar nome do arquivo atual para o clipboard" }
)
vim.keymap.set(
  "v",
  "<C-A-c>",
  "<Esc>:let @+ = expand('%')<CR>gv",
  { noremap = true, silent = false, desc = "Copiar nome do arquivo atual para o clipboard" }
)

local map = vim.keymap.set

-- Mapear Ctrl+A para selecionar tudo no modo normal, visual e de inserção
map({ "n", "i", "v" }, "<C-a>", "<ESC>ggVG", { noremap = true, silent = true, desc = "Selecionar tudo" })

-------------------------------------------------------------------------------------------------
-- Buffers
-------------------------------------------------------------------------------------------------
-- Fechar buffer atual
map("n", "<A-w>", ":BufDel<CR>", { noremap = true, silent = true, desc = "Fechar buffer atual" })
-- -- Fechar buffer atual ignorando mudanças
map("n", "<C-A-w>", ":BufDel!<CR>", { noremap = true, silent = true, desc = "Forçar fechar buffer atual" })
-- -- Fechar todos os outros buffers
map("n", "<A-e>", ":BufDelOthers<CR>", { noremap = true, silent = true, desc = "Fechar outros buffers" })
-- -- Fechar todos os buffers
map("n", "<C-A-e>", ":BufDelAll<CR>", { noremap = true, silent = true, desc = "Fechar todos os buffers" })

--------------------------------------------------------------------------
---
---
-- TELA DE BOAS VINDAS
--------------------------------------------------------------------------

-- Mapeamento da tecla F2
map("n", "<F2>", function()
  welcomeWindow.openWelcomeWindow()
end, { noremap = true, silent = true, desc = "Abrir tela de boas-vindas" })
