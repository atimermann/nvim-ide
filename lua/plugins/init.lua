return {
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup {
        width = 200,
        border = "rounded",
        width_ratio = 0.8, -- 90% da largura da janela do Neovim
        height_ratio = 0.8, -- 90% da altura da janela do Neovim
      }
    end,
    cmd = "Glow",
  },

  { "nvim-tree.lua", lazy = false },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
  },
  { "nvim-neotest/nvim-nio" },
  { "folke/which-key.nvim", lazy = false },
  --  {
  --    "williamboman/mason.nvim",
  --    config = true,  -- Configura o Mason automaticamente
  --  },
  --    lazy = false,
  --
  --    ---enables autocomplete for opts
  --    ---@module "auto-session"
  --    ---@type AutoSession.Config
  --    opts = {
  --      suppressed_dirs = { '~/', '~/projetos', '~/downloads', '/' },
  --      -- log_level = 'debug',
  --      --      args_allow_files_auto_save = true,
  --      --      auto_restore_last_session = true
  --    }
  --  }
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
