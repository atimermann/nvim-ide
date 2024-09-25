local map = vim.keymap.set

-- [[<cmd>lua print('shift+f5')<cr>]],
-- Atalhos de Seleção
map({'n', 'i'}, '<s-end>', '<esc>v$', {noremap = true})
map({'n', 'i'}, '<s-home>', '<esc>v0', {noremap = true})

map({'n', 'i'}, '<s-down>', '<esc>vj', {noremap = true})
map('v', '<s-down>', 'j', {noremap = true})

map({'n', 'i'}, '<s-up>', '<esc>vk', {noremap = true})
map('v', '<s-up>', 'k', {noremap = true})




-- map({'n', 'i'}, '<s-down>', [[<cmd>lua print('ok')<cr>]], {noremap = true})
--- Atalhos de Navegação


  
