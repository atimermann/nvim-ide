return {
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  { "nvim-tree.lua",         lazy = false },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  { 'nvim-neotest/nvim-nio' }
  --  {
  --    'rmagatti/auto-session',
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
