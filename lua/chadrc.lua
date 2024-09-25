-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- Default: "onedark"
M.base46 = {
  theme = "yoru",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  hl_override = {
    Visual = {
      bg = "grey_fg2",
      fg = "white",
    },
    -- Deixar os comentários mais claros
    Comment = {
      fg = "#666666", -- Cor mais clara para os comentários
      italic = true, -- Aplicar itálico aos comentários (opcional)
    },
    -- Também pode ajustar o destaque de comentários em sintaxes específicas, como:
    ["@comment"] = {
      fg = "#666666", -- Mesma cor mais clara
      italic = true,
    },
  },
}

return M
