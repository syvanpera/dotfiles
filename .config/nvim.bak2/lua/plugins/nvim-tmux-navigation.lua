return {
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true,
    },
    keys = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      return {
        { "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft },
        { "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown },
        { "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp },
        { "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight },
      }
    end,
  },
}
