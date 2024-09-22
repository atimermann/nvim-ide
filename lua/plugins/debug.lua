return {
  -- PHP (LARAVEL/LOGCOMEX)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "/home/logcomex/.nvm/versions/node/v20.16.0/bin/node", -- Usa node.js para rodar o adaptador
        args = { "/home/logcomex/.config/nvim/vscode-php-debug/out/phpDebug.js" }
      }
      dap.configurations.php = {
        {
          name = "Listen for Xdebug",
          type = "php",
          request = "launch",
          port = 9003,
          pathMappings = {
            ["/app"] = "/home/logcomex/projetos/log-os" -- Mapeamento dos caminhos de servidor para local
          }
        }
      }
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end
  }
}
