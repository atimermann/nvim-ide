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




