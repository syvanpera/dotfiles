return {
  "aserowy/tmux.nvim",
  opts = {
    navigation = {
      -- cycles to opposite pane while navigating into the border
      cycle_navigation = fale,

      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,

      -- prevents unzoom tmux when navigating beyond vim border
      persist_zoom = false,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = false,

      -- sets resize steps for x axis
      resize_step_x = 1,

      -- sets resize steps for y axis
      resize_step_y = 1,
    },
    swap = {
      -- cycles to opposite pane while navigating into the border
      cycle_navigation = false,

      -- enables default keybindings (C-A-hjkl) for normal mode
      enable_default_keybindings = false,
    }
  },
  -- keys = {
  --   { 'C-h', '<cmd>lua require("tmux").move_left()<CR>', desc = 'Move to pane left', silent = true },
  --   { 'C-j', '<cmd>lua require("tmux").move_bottom()<CR>', desc = 'Move to pane bottom', silent = true },
  --   { 'C-k', '<cmd>lua require("tmux").move_top()<CR>', desc = 'Move to pane top', silent = true },
  --   { 'C-l', '<cmd>lua require("tmux").move_right()<CR>', desc = 'Move to pane right', silent = true },
  -- }
}
