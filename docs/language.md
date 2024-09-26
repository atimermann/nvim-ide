# Suporte a Linguagem

Para adicionar suporte a nova linguagem várias etapas devem ser seguida:

## Configurar Sintexe Highlight

O plugin responsável por realizar o suporte a colorização de sintaxe é o `nvim-treesitter/nvim-treesitter`.

Adicione a linguagem em: ensure_installed 

Exemplo:

```lua
  {
    "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = {
            "vim",
            "lua",
            "vimdoc",
            "html",
            "css",
            "prisma"
          },
        },
      },
```

**DICA:**  Você pode utilizar all para instalar todas as linguagens, porém pode deixar o nvim mais pesado.

Você pode verificar as linguagens suportada e ativa com o comando:

`:TSModuleInfo`

Para instalar manualmente use o `TSInstall`, por exemplo:

`:TSInstall prisma`

Mais detalhes e documentação consulte:

https://github.com/nvim-treesitter/nvim-treesitter

## Configurar LSP

O LSP (Language Server Protocol) no Neovim é uma interface padronizada que permite a integração de servidores de linguagem com o editor. Ele oferece recursos avançados de desenvolvimento, como autocompletar, navegação entre definições, formatação de código e linting. 

Mais detales aqui: [LSP](./lsp.md)

Você primeiro precisa identificar o LSP responsável pela linguagem, dica consulte a refêrencia em:

    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

ou executando:

    :help lspconfig-all

Agora procure pela linguagem desejada, por exemplo Prisma:

Temos o `prismals`

portanto esse é o nome do server que temos que adicionar em server na configuração do lspconfig em:

    lua/configs/lspconfig.lua

Agora precisamos instalar o suporte a linguagem desejada (Language server), na documentação você vai encontrar:

```
cmd :
{ "prisma-language-server", "--stdio" }

```

Esse cmd é o nome do pacote no Mason (normalmente)

   `:MasonInstall prisma-language-server` 


Agora só reiniciar o nvim e pronto.


**Nota:** Alguns casos (como o PHPActor) o LSP não dá suporte a formatação de código. Nesse caso precisamos instalar um formatter com o

    Conform.vim

### Configurar linter e formatters com Conform

<!-- TODO: Documentar Confirm (ver lsp) -->




