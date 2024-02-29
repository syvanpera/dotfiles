return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    -- Mapping tab is already used by NvChad
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    -- The mapping is set to other key, see custom/lua/mappings
    -- or run <leader>ch to see copilot mapping section
  end,
}

-- return {
--   { -- copilot
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     build = ":Copilot auth",
--     opts = {},
--   },
--
--   { -- copilot cmp source
--     "nvim-cmp",
--     dependencies = {
--       {
--         "zbirenbaum/copilot-cmp",
--         dependencies = "copilot.lua",
--         opts = {},
--         config = function(_, opts)
--           local copilot_cmp = require("copilot_cmp")
--           copilot_cmp.setup(opts)
--           -- attach cmp source whenever copilot attaches
--           -- fixes lazy-loading issues with the copilot cmp source
--           require("lazyvim.util").lsp.on_attach(function(client)
--             if client.name == "copilot" then
--               copilot_cmp._on_insert_enter({})
--             end
--           end)
--         end,
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       table.insert(opts.sources, 1, {
--         name = "copilot",
--         group_index = 1,
--         priority = 100,
--       })
--     end,
--   },
-- }
