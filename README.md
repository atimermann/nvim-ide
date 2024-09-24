# Projeto de configuração do Neovim baseado no Nvchad

## Instalação

```sh
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
```desktop
[Desktop Entry]
Name=Neovim IDE
Comment=Edit files with Neovim in Kitty terminal
Exec=kitty --hold sh -c "cd ~/.config/nvim && ~/bin/nvim"
Icon=nvim
Terminal=false
Type=Application
Categories=Utility;TextEditor;

```

### Criar lista de projetos

Defina uma lista de proetos em `~/.project.lua` para carregar automaticamente com Alt-p
 
## Plugins / Funcionalidades

- [Depuração](./docs/debug.md) 
- [LSP/Formatter](./docs/lsp.md)
