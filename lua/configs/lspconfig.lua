
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Função simples para pegar o caminho do TypeScript (local ou global)
local function get_typescript_server_path(root_dir)
  local global_ts = "~/.nvm/versions/node/v20.16.0/lib/node_modules/typescript/lib"
  local found_ts = util.path.join(root_dir, "node_modules", "typescript", "lib")

  if util.path.exists(found_ts) then
    return found_ts
  else
    return global_ts
  end
end

local nvlsp = require "nvchad.configs.lspconfig"

-- Lista de servidores a serem configurados (sem volar)
local servers = { "html", "cssls", "phpactor", "ts_ls", "prismals" }

-- Configuração para cada LSP (sem volar)
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configuração manual para volar
lspconfig.volar.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    typescript = {
      -- Configura o tsdk para o caminho do TypeScript local ou global
      tsdk = get_typescript_server_path(vim.fn.getcwd()),
    },
  },
}
