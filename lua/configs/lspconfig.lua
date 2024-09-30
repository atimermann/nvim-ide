require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local nvlsp = require "nvchad.configs.lspconfig"

-- Lista de servidores a serem configurados (sem volar)
local servers = { "html", "cssls", "phpactor", "ts_ls", "prismals", "jsonls" }

local function get_typescript_server_path(root_dir)
  -- Executa `node -v` para obter a versão atual do Node.js
  local handle = io.popen("node -v")

  -- Verifica se o comando foi executado corretamente
  if not handle then
    print("Erro: Não foi possível executar `node -v`. Certifique-se de que o Node.js está instalado.")
    return nil
  end

  -- Lê a versão do Node.js
  local node_version = handle:read("*a")
  handle:close()

  -- Verifica se a leitura da versão foi bem-sucedida
  if not node_version or node_version == "" then
    print("Erro: Não foi possível obter a versão do Node.js.")
    return nil
  end

  -- Remove espaços e o "v" inicial da versão
  node_version = node_version:gsub("%s+", "")

  -- Expande o caminho do diretório home (~) para o TypeScript global
  local home = os.getenv("HOME")
  local global_ts = string.format("%s/.nvm/versions/node/%s/lib/node_modules/typescript/lib", home, node_version)

  -- Checa se há TypeScript local no projeto (node_modules)
  local util = require("lspconfig/util")  -- Certifique-se de importar corretamente o util
  local found_ts = util.path.join(root_dir, "node_modules", "typescript", "lib")

  -- Retorna o caminho do TypeScript local se existir, caso contrário o global
  if util.path.exists(found_ts) then
    return found_ts
  else
    return global_ts
  end
end


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
