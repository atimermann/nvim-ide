
local M = {}

function M.get_text()
  return {
    "Bem-vindo ao NeoVim - Pressione F2 para abrir/fechar esta referência.",
    "====================================================================",
    "",
    "Lista de atalhos:                                                   Comandos:",
    "-----------------                                                   ----------",
    "",
    "Comandos Gerais:                                                    NvChad:",
    "  Alt-P      - Abre janela para selecionar projetos recentes (use     :nvdash        - Exibe menu de funções como configuração de tema, atalhos, etc...",
    "               ctrl-d para remover um projeto da lista)               :nvCheatsheet  - Exibe lista de atalhos",
    "  Ctrl-N     - Abre lista de arquivos                                 ",
    "  Ctrl-S     - Salvar em qualquer momento                            Tradução",
    "  Ctrl-QQ    - Salvar e sair (todos os arquivos e sessões)            [V] alt-t   - Traduz o texto inline para inglês",
    "  Ctrl-K     - Formatar arquivo atual                                     alt-y   - Abre janela de tradução",
    "  Ctrl-Del   - Deleta linha toda do cursor (i)                        Na janela de tradução (modo insert):",
    "  Ctrl-L     - Próxima aba                                                ctrl-s  - Altera idioma de entrada (na janela de tradução)",
    "  Ctrl-;     - Comentar linha                                             ctrl-t  - Altera idioma alvo  (na janela de tradução)",
    "  Ctrl-Alt-H - Exibe lista de atalhos (WhichKey)                          alt-s   - Inverte texto de entrada com alvo",
    "  Ctrl-Alt-C - Copia o caminho do arquivo atual                           ctrl-e  - Altera motor de tradução",
    "  Ctrl-A     - Seleciona todo o texto",
    "",
    "Movimento entre janelas:                                            Depuração:",
    " Alt-Esq    - Mover para janela à esquerda                           F5   - Inicia depuração",
    " Alt-Dir    - Mover para janela à direita                            F6   - Abre interface de depuração",
    " Alt-Cima   - Mover para janela acima                                F7   - Adiciona Breakpoint",
    " Alt-Baixo  - Mover para janela abaixo                               F10  - Step Over",
    "                                                                     F11  - Step Into",
    "                                                                     F12  - Step Out",
    "Movimentação de Texto:                                              Outros Atalhos:",
    " Ctrl-Shift-Down  - Move linha ou seleção para baixo                  Alt-1   - Abrir diretório de configuração do Neovim",
    " Ctrl-Shift-Up    - Move linha ou seleção para cima                   Alt-0   - Voltar ao último diretório (Projeto)",
    "                                                                      Alt-RG  - Renderiza markdown com Glow",
    "Atalhos do Telescope:                                               Navegação:",
    " Alt-F   - Buscar arquivos                                            Ctrl-Alt-Up    - Método anterior",
    " Alt-G   - Live grep                                                  Ctrl-Alt-Down  - Próximo método",
    " Alt-B   - Listar buffers                                             Ctrl-Alt-Esq   - Volta à última mudança recente",
    " Alt-H   - Tags de ajuda                                              Ctrl-Alt-Dir   - Próxima mudança recente",
    " Alt-R   - Busca por Referência (Find Usages) (LSP)                   [d ou ]d       - Navega entre problemas (diagnóstico)",
    " Alt-O   - Lista Ultimos arquivos abertos                             Alt-D          - Navega até a definição (LSP)",
    " Alt-T   - Lista de TODOs do projeto                                  Alt-I          - Navega até a implementação (LSP)",
    " Alt-N   - Abre tela de seleção de Template",
    "Gerenciamento de Buffers:                                           Rest.nvim (http file)",
    " Alt-W        - Fechar buffer atual                                   Alt-x   - Executa requisição sob o cursor",
    " Ctrl-Alt-W   - Forçar fechar buffer atual ignorando mudanças         Alt-l   - Executa ultima requisiçãAlt-O",
    " Alt-E        - Fechar todos os outros buffers",
    " Ctrl-Alt-E   - Fechar todos os buffers",
    "",
    "Outros Comandos de Navegação:",
    " :{número da linha}  - Move o cursor para uma linha específica",
  }
end

return M
