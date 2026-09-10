vim.pack.add({
  "https://github.com/aserowy/tmux.nvim",
})

require("tmux").setup({
  navigation = {
    -- cycles to opposite pane while navigating into the border
    cycle_navigation = false,

    -- prevents unzoom tmux when navigating beyond vim border
    persist_zoom = false,

    -- enables default keybindings (C-hjkl) for normal mode
    enable_default_keybindings = true,
  },
  resize = {
    -- sets resize steps for x axis
    resize_step_x = 1,

    -- sets resize steps for y axis
    resize_step_y = 1,

    -- enables default keybindings (A-hjkl) for normal mode
    enable_default_keybindings = false,
  },
  swap = {
    -- cycles to opposite pane while navigating into the border
    cycle_navigation = false,

    -- enables default keybindings (C-A-hjkl) for normal mode
    enable_default_keybindings = false,
  }
})
