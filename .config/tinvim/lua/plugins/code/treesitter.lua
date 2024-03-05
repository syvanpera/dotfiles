return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      local auto_install = require("lib.util").get_user_config("auto_install", true)
      local installed_parsers = {}
      if auto_install then
        installed_parsers = require("plugins").ts_parsers
      end

      -- local textobjects = require('plugins.lang.textobjects')

      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        ensure_installed = installed_parsers,
        sync_install = false,
        ignore_install = {},
        auto_install = true,

        -- textobjects = textobjects,
        autopairs = { enable = true },
        -- endwise = { enable = true },
        -- autotag = { enable = true },
        matchup = { enable = true },
        indent = { enable = true },

        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },

        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
