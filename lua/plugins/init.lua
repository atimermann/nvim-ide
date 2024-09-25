local project_paths = {}
local project_list_file = vim.fn.expand "~/.projects.lua"

if vim.fn.filereadable(project_list_file) == 1 then
  project_paths = dofile(project_list_file)
end

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
  {
    "nvim-tree.lua",
    lazy = false,
    --[[ config = function()
      require("nvim-tree").setup {
        filters = {
          dotfiles = false,
        },
      }
    end, ]]
  },

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
  {
    "ojroques/nvim-bufdel",
    lazy = false,
    config = function()
      require("bufdel").setup {
        next = "tabs",
        quit = false, -- quit Neovim when last buffer is closed
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("bufdel").setup {

        enhanced_diff_hl = true,
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see |diffview-config-view.x.layout|.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
            disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = false, -- See |diffview-config-view.x.winbar_info|
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = true, -- See |diffview-config-view.x.winbar_info|
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
            disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = true, -- See |diffview-config-view.x.winbar_info|
          },
        },
      }
    end,
  },
  {
    "coffebar/neovim-project",
    opts = {
      projects = project_paths,
      picker = {
        type = "telescope", -- or "fzf-lua"
      },
      dashboard_mode = false,
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append "globals" -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      -- optional picker
      { "ibhagwan/fzf-lua" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      -- Carregar o cmp e o mapeamento já existente
      local cmp = require "cmp"

      -- Adicionar ou sobrescrever o mapeamento para <Up> e <Down>
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<PageDown>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            for _ = 1, 10 do
              cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
            end
          else
            fallback()
          end
        end),
        ["<PageUp>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            for _ = 1, 10 do
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
            end
          else
            fallback()
          end
        end),
      })

      -- Aplicar as configurações do cmp com os novos mapeamentos
      cmp.setup(opts)
    end,
  },
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
  -- 	largura	ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
