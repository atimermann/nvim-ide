
local map = vim.keymap.set

-- Função para confirmar antes de salvar todos os arquivos
local function confirm_save_all()
    local answer = vim.fn.input("Tem certeza que quer salvar todos os arquivos? (y/n): ")
    if answer:lower() == "y" then
        vim.cmd("wall")
    else
        print("Operação cancelada")
    end
end

-- Função para confirmar antes de salvar e sair
local function confirm_save_and_quit()
    local answer = vim.fn.input("Tem certeza que quer salvar todos os arquivos e sair? (y/n): ")
    if answer:lower() == "y" then
        vim.cmd("wa")  -- Salva todos os arquivos
        vim.cmd("qa")  -- Fecha todos os buffers e sai do Vim
    else
        print("Operação cancelada")
    end
end

-- Mapeando a combinação de teclas para perguntar antes de salvar todos os arquivos
map({ "n", "i", "v" }, "<C-s><C-s>", confirm_save_all, { desc = "Salvar todos os arquivos com confirmação" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Salvar arquivo" })

-- Mapeamento para perguntar antes de salvar e sair
map({ "n", "i", "v" }, "<C-q><C-q>", confirm_save_and_quit, { desc = "Salvar sessão, salvar tudo e sair com confirmação", silent = true })
