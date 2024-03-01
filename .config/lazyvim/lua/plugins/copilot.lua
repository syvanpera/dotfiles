return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
      vim.keymap.set(
        "i",
        "<C-f>",
        function()
          vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
        end,
        { desc = "Copilot Accept", replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true }
      )
    end,
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   lazy = false,
  --   -- cmd = "Copilot",
  --   -- event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  --
  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot-cmp",
  --       dependencies = "copilot.lua",
  --       opts = {},
  --       config = function(_, opts)
  --         local copilot_cmp = require("copilot_cmp")
  --         copilot_cmp.setup(opts)
  --         -- attach cmp source whenever copilot attaches
  --         -- fixes lazy-loading issues with the copilot cmp source
  --         require("lazyvim.util").lsp.on_attach(function(client)
  --           if client.name == "copilot" then
  --             copilot_cmp._on_insert_enter({})
  --           end
  --         end)
  --       end,
  --     },
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --
  --     table.insert(opts.sources, 1, {
  --       name = "copilot",
  --       -- group_index = 1,
  --       -- priority = 100,
  --     })
  --
  --     opts.mapping = cmp.mapping.preset.insert({
  --       ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-d>"] = cmp.mapping.scroll_docs(4),
  --       -- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<C-f>"] = cmp.mapping.confirm({ select = false }),
  --       ["<C-y>"] = cmp.mapping.confirm({ select = false }),
  --       -- ["<C-Space>"] = cmp.mapping.complete(),
  --       ["<C-e>"] = cmp.mapping.abort(),
  --       ["<C-g>"] = cmp.mapping.abort(),
  --       ["<S-CR>"] = cmp.mapping.confirm({
  --         behavior = cmp.ConfirmBehavior.Replace,
  --         select = true,
  --       }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<C-CR>"] = function(fallback)
  --         cmp.abort()
  --         fallback()
  --       end,
  --     })
  --   end,
  -- },
}
