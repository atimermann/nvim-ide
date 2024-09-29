-- Configurações VIM

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.shell = "/bin/bash"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
  require "mappings.editing"
  require "mappings.saveload"
  require "mappings.telescope"
end)

-- Carrega o módulo "welcome_window"
local welcomeWindow = require "welcome-window"

-- Define o autocmd que chama a função open_welcome_window ao iniciar o Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Abre o NvimTree
    vim.cmd "NvimTreeOpen"

    -- Abre a janela de boas-vindas
    welcomeWindow.openWelcomeWindow()
  end,
})

-----------------------------------------------------------------------------------
-- INICIALIZA ARQUIVO DE CONFIGURAÇÂO DO PROJETO
-----------------------------------------------------------------------------------

-- Verifica se o arquivo ~/.projects.lua existe
local projects_file = vim.fn.expand "~/.projects.lua"

-- Função para escrever o conteúdo no arquivo, caso ele não exista
local function create_projects_file()
  local content = [[
-- ~/.projects.lua
return { 
  "~/.config/nvim"
}
]]
  -- Abre o arquivo para escrita e grava o conteúdo
  local file = io.open(projects_file, "w")
  if file then
    file:write(content)
    file:close()
    print "Arquivo ~/.projects.lua criado com sucesso!"
  else
    print "Erro ao criar o arquivo ~/.projects.lua"
  end
end

-- Verifica se o arquivo é legível (existe)
if vim.fn.filereadable(projects_file) == 0 then
  create_projects_file()
end

-- Remove auto comment
vim.cmd [[autocmd FileType * setlocal formatoptions-=cro]]


require("telescope").load_extension('find_template')
