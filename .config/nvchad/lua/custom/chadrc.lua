---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  lsp_semantic_tokens = true,

  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  extended_integrations = { "trouble" },

  telescope = { style = "bordered" },
  statusline = {
    theme = "vscode_colored",
    separator_style = "round"
  },
  nvdash = {
    load_on_startup = true,
  },
  cmp = {
    style = "atom_colored"
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
