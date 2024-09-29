-- Função personalizada para filtrar processos Node.js
--[[ local function pick_node_process()
  local dap_utils = require "dap.utils"

  -- Chama a função pick_process passando um filtro válido
  return dap_utils.pick_process {
    filter = function(process)
      -- Filtra processos que possuem 'node' no nome ou que foram iniciados com '--inspect'
      return string.sub(process.name, 1, 4) == "node" and process.name:find "--inspect"
    end,
  }
end ]]

local function pick_node_process()
  local dap_utils = require "dap.utils"

  -- Pega todos os processos
  local all_processes = dap_utils.get_processes()

  -- Filtra os processos que atendem às condições
  local filtered_processes = {}

  for _, process in ipairs(all_processes) do
    if string.sub(process.name, 1, 4) == "node" and process.name:find "--inspect" then
      table.insert(filtered_processes, process)
    end
  end

  -- Se houver apenas um processo, retorna o ID diretamente
  if #filtered_processes == 1 then
    return filtered_processes[1].pid
  end

  -- Caso contrário, abre o seletor para escolher entre os processos filtrados
  return dap_utils.pick_process {
    filter = function(process)
      return string.sub(process.name, 1, 4) == "node" and process.name:find "--inspect"
    end,
  }
end
return {
  -- PHP (LARAVEL/LOGCOMEX)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      --------------------------------------------
      -- PHP
      --------------------------------------------

      dap.adapters.php = {
        type = "executable",
        command = "node", -- verifique se funciona assim, se não por caminho completo
        args = { os.getenv "HOME" .. ".config/nvim/vscode-php-debug/out/phpDebug.js" },
      }
      dap.configurations.php = {
        {
          name = "Listen for Xdebug",
          type = "php",
          request = "launch",
          port = 9003,
          pathMappings = {
            ["/app"] = "/home/logcomex/projetos/log-os", -- Mapeamento dos caminhos de servidor para local
          },
        },
      }
      --------------------------------------------
      -- Javascript / NODEJS
      -- https://github-wiki-see.page/m/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#node-debug2
      --------------------------------------------
      -- NOTE: Não funcionou com versão do vscode-node-debug2

      --dap.adapters.node2 = {
      --type = "executable",
      --command = "node",
      --args = { os.getenv "HOME" .. ".config/nvim/adapters/vscode-node-debug2/out/src/nodeDebug.js" },
      --}

      -- Versão instalada com MasonInstall node-debug2-adapter
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }

      dap.configurations.javascript = {
        {
          name = "Launch",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = "Attach to process",
          type = "node2",
          request = "attach",
          processId = pick_node_process,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
}
