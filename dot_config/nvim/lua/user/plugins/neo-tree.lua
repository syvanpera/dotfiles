return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function() vim.wo.statusline = " " end,
        },
      },
      window = {
        width = 30,
        mappings = {
          ["<tab>"] = "open",
        },
      },
    })
  end,
}
