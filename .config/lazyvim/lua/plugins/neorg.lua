return {
  "nvim-neorg/neorg",
  -- tag = "*",
  build = ":Neorg sync-parsers",
  lazy = true,
  ft = "norg", -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
              helen = "~/projects/helen/notes",
            },
          },
        },
      },
    })
  end,
}
