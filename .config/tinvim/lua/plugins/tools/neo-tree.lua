return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
        },
      },
      window = {
        mappings = {
          ["<tab>"] = "open",
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    })
  end,
  keys = {
    {
      "<M-e>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root() })
      end,
    },
  },
}
