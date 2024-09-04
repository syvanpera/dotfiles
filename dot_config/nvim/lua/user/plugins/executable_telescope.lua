return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    -- "nvim-telescope/telescope-project.nvim",
    -- "ahmedkhalf/project.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "camgraff/telescope-tmux.nvim",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/git-worktree.nvim",
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { " " },
        },
        mappings = {
          i = {
            ["<C-l>"] = actions.cycle_history_next,
            ["<C-h>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
            ["<C-g>"] = actions.close,
          },
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope" (...)
    local telescope = require "telescope"
    -- telescope.load_extension "projects"
    telescope.load_extension "tmux"
    telescope.load_extension "file_browser"
    telescope.load_extension "harpoon"
    telescope.load_extension "git_worktree"
    -- telescope.load_extension "project"
  end,
}
