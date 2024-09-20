**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!


# Instalação

NeoVim - NvChad
===============
Criado domingo 15 setembro 2024


* NeoVim é uma versão melhorada do VIM
* NvChat é uma configuração pronta do NVChat que permite funcionar como IDE por linha de comando
* Neovim-Qt é uma versão visual do NeoVim para melhor integração com o KDE


Instalação
==========

Neovim
------

* Necessário baixar ultima versão direto no repositório

**Exemplo:**
<https://github.com/neovim/neovim/releases/tag/v0.10.1>
<https://github.com/neovim/neovim/releases/download/v0.10.1/nvim.appimage>

renomeie o nvim.appimage e jogue na pasta <file:///home/andre/bin>

**PRONTO**
	
NVCHAT
------
Configurar o neovim manualmente é uma tarefa herculana, por isso existem soluções que já carregam essas configurações, a mais famosa é o nvchat:
<https://nvchad.com/docs/quickstart/install>

Basta copiar a a configuração para : **<file:///home/andre/.config/nvim>**

O NvChat é configurado via scripts lua que pode ser extremamente desafiador e confuso!

Run **:MasonInstallAll** command after lazy.nvim finishes downloading plugins.
Delete the **.git** folder from nvim folder.

Execute **Lazy sync** para atualizar

Lazy é um gerenciador de plugins para o Neovim utilizado pelo nvchat:
<https://lazy.folke.io/installation>

NerdFonts
---------
<https://nvchad.com/docs/quickstart/install>

Para os icones funcionarem corretamente no terminal é necessário instalar o nerfonts:


* **Nerd Font as your terminal font.**

Make sure the nerd font you set doesn't end with Mono to prevent small icons.
__Example :__ **JetbrainsMono Nerd Font** and not JetbrainsMono Nerd Font Mono

Guia de instalação de uma fonte no sistema:
-------------------------------------------
<https://dev.to/almatins/install-nerdfont-or-any-fonts-using-the-command-line-in-debian-or-other-linux-467o>

Agora altere a fonte do seu terminal para q funciona


## Neovim-Qt

**Neovim-Qt** é uma interface gráfica (GUI) para o editor de texto Neovim. Ele oferece uma experiência gráfica, permitindo o uso de recursos do Neovim com suporte a mouse, fontes personalizadas, e integração visual, sem depender de um terminal.

### Desabilitar a Tabline Gráfica

Por padrão, o Neovim-Qt exibe uma tabline gráfica (barra de abas) na interface. Para usar a tabline nativa do Neovim (renderizada no terminal) e desativar a tabline gráfica do Qt, siga os passos abaixo:

1. **Localização do Arquivo de Configuração**:
   O arquivo de configuração do Neovim-Qt é armazenado em:
   
   - **Linux**: `~/.config/nvim-qt/nvim-qt.conf`

2. **Desativando a Tabline Gráfica**:
   
   Abra o arquivo `nvim-qt.conf` e adicione a seguinte configuração:

```ini
   [General]
   ext_tabline=false
```

### Configuração Inicial

Crie o arquivo `~/.config/nvim/ginit.vim` e cole o seguinte conteúdo:

```vim
   " Habilitar o uso do mouse
   set mouse=a

   " Definir a fonte para o editor
   set guifont=UbuntuMono\ Nerd\ Font:h10
```
