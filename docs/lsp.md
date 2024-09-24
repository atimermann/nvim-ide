# LSP / Formatter


## LSP

O LSP (Language Server Protocol) no Neovim é uma interface padronizada que permite a integração de servidores de linguagem com o editor. Ele oferece recursos avançados de desenvolvimento, como autocompletar, navegação entre definições, formatação de código e linting. 

No Neovim, o LSP permite que os desenvolvedores configurem servidores de linguagem para várias linguagens de programação, otimizando a experiência de codificação e automatizando tarefas comuns. Através de plugins como nvim-lspconfig, é possível configurar e personalizar o comportamento do nvim-lspconfig

**Nota:**: Depois que os binários estiverem instalados, você terá que configurá-los para funcionar corretamente com LSP, conform.nvim, nvim-lint, nvim-dap etc. NvChad não fornece nenhuma configuração de idioma além de lua.

Use o Mason pra gerenciar os pacoes usados pelo LSP

o nvim-lspconfig serve especificamente para configurar servidores de linguagem que implementam o LSP (Language Server Protocol). 
O LSPConfig é utilizado para conectar o Neovim a servidores de linguagem que oferecem recursos como:

- Autocompletar
- Navegação entre definições
- Documentação embutida
- Diagnósticos e linting
- Formatação (quando o servidor LSP suporta)

Formatadores como php-cs-fixer, prettier, e black (para Python) não implementam o LSP, e por isso não podem ser configurados diretamente através do nvim-lspconfig.

Phpactor é um LSP, mas não suporta formatter

### Instalação de novos lsps

É complexo encontrar o LSP certo para linguagem certa necessário buscar na internet. Por exemplo.

Você pode encontrar a lista de LSP suportado pelo lspconfig aqui:

`:help lspconfig-all`

porem o nome listado ali não é o mesmo que você vai utilizar no Mason para instalar.
Documente cada linguagem


## Mason

Gerenciador de pacotes portátil para Neovim que roda em qualquer lugar que o Neovim roda. Instale e gerencie facilmente servidores LSP, servidores DAP, linters e formatadores.

Mason é apenas um gerenciador de pacote para LSP, DAP, Linter e Formatter.

Execute:

    `:Mason`

Para iniciar o gerenciador de pacote. Outros comandos:


- MasonInstall: Instala pacotes.
- MasonInstallAll: ???
- MasonUninstall: Remove um pacote


Diretório de instalação dos pacotes do Mason para teste local:

`~/.local/share/nvim/mason/bin` 

## Conform

Plug-in de formatador leve, mas poderoso para Neovim.

Alguns formatadores não funcionam com o LSP padrão, então vamos utilizar o Conform. Ex: PHP

Utilize o Mason para instalar formatadores usados pelo Conform

Abaixo a configuração do conform para utilizar o LSP como fallback para formatar o código (ou seja, se não existir formatter com conform tenta com LSPConfig)


lua/configs/conform.lua:
```lua
local options = {
  formatters_by_ft = {
    --  lua = { "stylua" },
    php = { "php-cs-fixer" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  formatters = {
    ["php-cs-fixer"] = {
      command = vim.fn.stdpath "data" .. "/mason/bin/php-cs-fixer",
      args = {
        "fix",
        "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        "$FILENAME",
      },
      stdin = false,
    },
  },
  notify_on_error = true,
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

```

Atalho (lua/mappings.lua) (Ctrl+k):

```lua
map({ "n", "i" }, "<C-k>", function()
  require("conform").format { async = true }
end, { desc = "Format current file", silent = false })
```

Refêrencia de configuração: https://github.com/stevearc/conform.nvim/blob/master/doc/conform.txt

O Conform não exibe logs na barra status do nvim, e sim em um arquivo externom para depurar e acompanhar os logs utilize:

    `tail -f ~/.local/state/nvim/conform.log`


## CMP

nvim-cmp é um plugin de mecanismo de auto-completar para neovim escrito em Lua.


# Configurando ambiente para PHP

Vamos configurar o LSP Phpactor, o php-cs-fixer com conform para formatar o código automaticamente:

## Instalando phpactor e php-cs-fixer via Mason:

Abra o Neovim e execute o seguinte comando para abrir o Mason:

```vim
:Mason
:MasonInstall phpactor
:MasonInstall php-cs-fixer
```
    
## Instalando dependencia

Necessário ter o PHP 8.3 instalado. Dica de como instalar no ubuntu:

```bash
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.3 php8.3-cli
sudo update-alternatives --config php
```

## Habilitando o phpactor no LSPConfig

Edite o arquivo `lua/configs/lspconfig.lua`:

Adicione, phpactor em servers:

```lua
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "phpactor" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
```


## Configurando o Conform.nvim com php-cs-fixer

Agora vamos usar o Conform.nvim para configurar a formatação automática de código PHP utilizando o php-cs-fixer com as regras PSR-12.

```lua
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "php-cs-fixer" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  formatters = {
    ["php-cs-fixer"] = {
      command = vim.fn.stdpath("data") .. "/mason/bin/php-cs-fixer",
      args = {
        "fix",
        "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        "$FILENAME",
      },
      stdin = false,
    },
  },
  notify_on_error = true,
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
```

### Problemas

- Utilize o comando `:ConformInfo` com o arquivo alvo aberto para verificar se os formatters foram carregados corretamente
- Você pode utilizar `:LspInfo` com o arquivo alvo aberto para verificar se o LSP suporta formatter. Lembrando que phpactor não suporte , por isso usamos o conform.
- Execute `:lua require("conform").format()` pra testar a formatação com o conform.

# Instalando Suporte Typescript,Javascript,vue, nodejs, etc...

Instale o nodejs e o typescript:

`npm install -g typescript`

No lspconfig use ts_ls para typescript e javascript, e volar para vue3

`local servers = { "html", "cssls", "ts_ls", "volar"}`

Use o Mason para instalar suporte com:

```
:MasonInstall typescript-language-server
:MasonInstall vue-language-server
```

O volar exige o typescript instalado localmente, para que ele carregue global use o código abaixo (se o estiver usando nvm):


```lua

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
local servers = { "html", "cssls", "phpactor", "ts_ls" }

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

```
