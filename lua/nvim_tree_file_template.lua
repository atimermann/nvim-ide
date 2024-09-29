
local M = {}

-- Função para criar arquivo com base em template
function M.create_file_with_template()

  print('OK')
  -- Obtém o diretório atual do nvim-tree
  local current_path = require("nvim-tree.lib").get_node_at_cursor().absolute_path

  -- Solicita o nome do arquivo
  local file_name = vim.fn.input("File name: ", current_path .. "/")

  if file_name == "" then
    print("Nome do arquivo inválido")
    return
  end

  -- Cria o arquivo e abre no buffer
  -- vim.cmd("edit " .. file_name)

  -- Executa o Telescope para selecionar o template
  --[[ require("telescope.builtin").find_files({
    prompt_title = "Select a template",
    cwd = "~/.config/nvim/templates", -- Caminho dos templates
    attach_mappings = function(prompt_bufnr, map)
      -- Ao selecionar o template, abre o template e insere no buffer
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      map("i", "<CR>", function()
        local selected_template = action_state.get_selected_entry().path
        actions.close(prompt_bufnr)

        -- Lê o template e insere no arquivo
        local template_content = {}
        local template_file = io.open(selected_template, "r")
        if template_file then
          template_content = template_file:read("*a")
          template_file:close()
          vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template_content, "\n"))
        else
          print("Erro ao abrir o template")
        end
      end)

      return true
    end,
  }) ]]
end

return M
