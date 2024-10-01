local project_paths = {}
local project_list_file = vim.fn.expand "~/.projects.lua"
local nvim_tree_file_template = require "../nvim_tree_file_template"

if vim.fn.filereadable(project_list_file) == 1 then
  project_paths = dofile(project_list_file)
end

local function my_on_attach(bufnr)
  -- TODO: Não funcionou
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  --vim.keymap.set("n", "ç", print('ok'), opts('Nem file by template'))
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
    -- require("nvim-tree").setup {
      ---
      --- on_attach = my_on_attach,
      ---
    -- },
  },
  {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- ícones de dependência
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- Comandos que carregam o plugin
    config = function()
      require("nvim-tree").setup {}
    end,
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
  --  { "JoosepAlviste/nvim-ts-context-commentstring" },
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
      -- Load cmp and existing mapping
      local cmp = require "cmp"

      -- opts.completion = {
      -- autocomplete = true, -- Desabilita o popup automático
      -- }

      -- Adicionar ou sobrescrever o mapeamento para <Up> e <Down>
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        -- ["<CR>"] = cmp.mapping(function(fallback)
        -- fallback() -- Deixa o Enter funcionar normalmente quando não houver popup
        -- end, { "i", "s" }), -- Sobrescreve o Enter para evitar que ele confirme o item do autocomplete
        ["<Tab>"] = cmp.mapping(function(fallback)
          fallback() -- Deixa o Enter funcionar normalmente quando não houver popup
        end, { "i", "s" }), -- Sobrescreve o Enter para evitar que ele confirme o item do autocomplete
        -- ["<C-Enter>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
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
        -- Mapeando Esc para cancelar o autocomplete e fechar o popup
        ["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort() -- Fecha o menu e cancela a seleção
          else
            fallback() -- Se o autocomplete não estiver visível, o comportamento padrão do Esc
          end
        end, { "i" }),
      })

      -- Aplicar as configurações do cmp com os novos mapeamentos
      cmp.setup(opts)
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  { "rest-nvim/rest.nvim", lazy = true, cmd = "Rest" },
  {
    "potamides/pantran.nvim",
    lazy = false,
    config = function()
      require("pantran").setup {
        default_engine = "google",
        command = {
          default_mode = "replace",
        },
      }
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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "prisma",
        "http",
      },
    },
  },
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup {
        -- config in there
        temp_dir = "~/.config/nvim/templates",
        author = "André Timermann",
        email = "andre@timermann.com.br",
      }
    end,
  },
}
