# Projeto de configuração do Neovim baseado no Nvchad

## Instalação

```sh

# Dependencia Telescope 
sudo apt install ripgrep
sudo apt install kitty -y
```

## Configuração

### Configuração do Kitty

Edite o arquivo:
~/.config/kitty/kitty.conf
```
allow_remote_control    yes
font_size               7.0

font_family             JetBrainsMono NF Thin
bold_font               auto
italic_font             auto
bold_italic_font        auto
```
**Dica:** Use o comando `kitty list-fonts` para listar as fontes disponíveis.

### Criar atalho desktop

Salve o arquivoa baixo em: `~/.local/share/applications/nvim-kitty.desktop`
```
[Desktop Entry]
<!-- TODO:  -->
```

### Criar lista de projetos
Defina uma lista de proetos em `~/.project.lua` para carregar automaticamente com Alt-p
 
## Plugins / Funcionalidades

- [Depuração](./docs/debug.md) 
- [Adicionando suporte a novas linguagens](./docs/language.md)
- [LSP/Formatter](./docs/lsp.m)
