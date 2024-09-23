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
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
