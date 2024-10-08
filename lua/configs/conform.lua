local options = {
  log_level = vim.log.levels.INFO,
  formatters_by_ft = {
    --  lua = { "stylua" },
    php = { "php-cs-fixer" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  formatters = {
    ["php-cs-fixer"] = {
      command = vim.fn.stdpath "data" .. "/mason/bin/php-cs-fixer",
      args = {
        "fix",
        "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        "$FILENAME",
      },
      stdin = false,
    },
  },
  notify_on_error = true,
  notify_no_formatters = true,
  -- Desabilita o format on save
  format_on_save = false,
    default_format_opts = {
    lsp_format = "fallback",
  },
}

return options
