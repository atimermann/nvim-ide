local map = vim.keymap.set

-- [[<cmd>lua print('shift+f5')<cr>]],

---------------------------------------------------------------------------
-- Atalhos de Seleção
---------------------------------------------------------------------------
map({ "n", "i" }, "<s-home>", "<esc>v0", { noremap = true, desc = "Selecionar até o início da linha" })
map({ "n", "i" }, "<s-end>", "<esc>v$", { noremap = true, desc = "Selecionar até o fim da linha" })

map({ "n", "i" }, "<s-down>", "<esc>vj", { noremap = true, desc = "Selecionar até a linha abaixo" })
map({ "v" }, "<s-down>", "j", { noremap = true, desc = "Selecionar até a linha abaixo" })

map({ "n", "i" }, "<s-up>", "<esc>vk", { noremap = true, desc = "Selecionar até a linha acima" })
map("v", "<s-up>", "k", { noremap = true, desc = "Selecionar até a linha acima" })

---------------------------------------------------------------------------
-- Atalhos de Navegação (adicione aqui os que você desejar)
---------------------------------------------------------------------------

-- Mapeia a tecla Home para ir ao primeiro caractere não em branco no modo normal e visual
map({'n', 'v'}, '<Home>', '^', { noremap = true, silent = true, desc = "Mover para o primeiro caractere não em branco" })
-- Mapeia a tecla Home no modo de inserção
map('i', '<Home>', '<C-o>^', { noremap = true, silent = true, desc = "Mover para o primeiro caractere não em branco no modo inserção" })


---------------------------------------------------------------------------
-- Atalhos de Movimentação de texto
---------------------------------------------------------------------------
vim.cmd [[vnoremap <C-S-Up> :m '<-2<CR>gv=gv]] -- Só funciona usando norepam direto, problema com vim.keymap.set
map("v", "<c-s-down>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Mover seleção visual para baixo" })

map("i", "<c-s-up>", "<esc>:m -2<CR>gi", { noremap = true, desc = "Mover seleção para cima" })
map("i", "<c-s-down>", "<esc>:m +1<CR>gi", { noremap = true, desc = "Mover seleção para baixo" })

---------------------------------------------------------------------------
-- Atalhos edição de texto
---------------------------------------------------------------------------
vim.keymap.set('i', '<C-delete>', '<C-o>dd', { noremap = true, silent = true })

-- Ctrl+W modo inserção remove palavra anterior

