# Instalando e Configurando um depurador no Neovim

**NOTAS:** 
- O Mason instala debuggers, simplificando o processo, revisar a documentação abaixo para configurar o PHP com Mason (não precisa do plugin do vscode)
- O depurador do nodejs foi instalado via Mason e funcionou perfeitamente, enquanto do vs code não. veja configurações.
- Referência de configuração em:
    - https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#node-debug2
    - https://github-wiki-see.page/m/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript



Vamos utilizar os seguintes plugins para habilitar depuração no neovim:
- "mfussenegger/nvim-dap"
- "rcarriga/nvim-dap-ui"

O primeiro é o depurador em si e o segundo disponibiliza uma interface avançada de debug.

O nvim-dap não disponibiliza nenhum atalho, vamos fazer isso manualmente mais tarde

Existe outra ferramenta mais antiga chamada [viminspector](https://github.com/puremourning/vimspector), que pode ser usado caso precise no futuro.

## Configurando um novo depurador com PHP (xdebug)

Primeiramente vamos criar um arquivo de configuração em: `~/.config/nvim/lua/configs/plugins/debug.lua` caso não exista. Vamos centralizar todos os debugs aqui.

- Nessa configuração inicial vamos manter a configuração do depurador local, é possivel carregar um depurador por projeto (será visto no futuro)

### Instalando o vscode-php-debug

No php será utilizado do plugin de debug do vscode, que será se conectará ao nvim-dap para realizar a depuração.

Clone o vscode-php-debug do github (já fiz isso e deixei no diretório ~/.config/nvim/vscode-php-debug)

```bash
git clone https://github.com/xdebug/vscode-php-debug.git
cd vscode-php-debug
npm install

# Ignore os warning de versão, isso não será um problema

npm run build

```

Com isso vamos ter disponível o arquivo `out/phpDebug.js`

Este script será responsável por atuar como servidor de conexão do XDEBUG

### Configurando o nvim-dap

No arquivo debug.lua adicione:

```lua
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node", -- Usa node.js para rodar o adaptador ATENÇÂO, VERIFICAR SE O NODE está acessivel pelo nvim, se não por caminho completo
        args = { "<HOME_PATH>/.config/nvim/vscode-php-debug/out/phpDebug.js" } -- verificar atalho para home
      }
      dap.configurations.php = {
        {
          name = "Listen for Xdebug",
          type = "php",
          request = "launch",
          port = 9003,
          pathMappings = {
            ["/app"] = "/home/logcomex/projetos/log-os" -- Mapeamento dos caminhos de servidor para local
          }
        }
      }
    end
  },
```
- Como o plugin roda em nodejs em command vamos especificar o caminho completo do node
- Em args vamos definir o caminho completo do script do phpDebug.js
- Em configuração verifique se a porta é a mesma definida no XDEBUG (normalmente 9003)
- E em pathMapping, vamos mapear o caminho remoto em execução (quando o php está rodando em docker) e na direita o código fonte local
- Note o nome da configuração e do adaptador ".php" ele deve ser o a extensão do arquivo atualmente aberto no editor.

### Executando o depurador

- Primeiramente precisamos iniciar o servidor que vai aguardar as conexões do xdebug. Para isso é necessário que um arquivo .php esteja aberto no editor
- Agora execute: 

    `:lua require'dap'.continue()` (mais pra frente vamos criar atalho para este comando)

- Caso queira verificar se o servidor está de pé, use nmap:
    
    `nmap localhost -p 9003`

Agora rodar o código php. Se tudo der certo uma seta vai aparecer na linha onde o breackpoint foi adicionado (Dica: use `xdebug_break();` para testar)


### Configurando o nvim-dap-ui

Adicione o seguinte código em debug.lua:

```lua

 {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end
  }

```

Instale a dependência `nvim-neotest/nvim-nio` caso ainda não tenha feito em init.lua:

```lua
 { 'nvim-neotest/nvim-nio' }
```

Para entrar na interface de depuração do nvim-dap-ui execute:

```
:lua require("dapui").toggle()
```

execute novamente para voltar ao código.



## Atalhos para o depurador

- `F5:`  Inicia o debuger
- `F6:`  Abre a interfação de depuração (dapui)
- `F7:`  Adicione/Remove breackpoint

- `F10:` STEP OVER
- `F11:` STEP INTO
- `F12:` STEP OUT


## TODO:

- Descobrir como adicionar watcher e colocar um atalho
- Descobrir como executar expressões
- Ver melhor forma de voltar o arquivo para original
- 
