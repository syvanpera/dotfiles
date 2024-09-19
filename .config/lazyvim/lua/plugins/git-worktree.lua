return {
  "syvanpera/git-worktree.nvim",
  config = function()
    require("telescope").load_extension("git_worktree")
  end,
  keys = {
    {
      "<leader>gw",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "List git worktrees",
    },
    {
      "<leader>ga",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "Create a new git worktree",
    },
  },
}

-- return {
--   "polarmutex/git-worktree.nvim",
--   version = "^2",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim",
--   },
--   config = function()
--     require("telescope").load_extension("git_worktree")
--
--     local Hooks = require("git-worktree.hooks")
--
--     Hooks.register(Hooks.type.SWITCH, Hooks.builtins.update_current_buffer_on_switch)
--   end,
--   keys = {
--     {
--       "<leader>gw",
--       function()
--         require("telescope").extensions.git_worktree.git_worktree()
--       end,
--       desc = "List git worktrees",
--     },
--     {
--       "<leader>ga",
--       function()
--         require("telescope").extensions.git_worktree.create_git_worktree()
--       end,
--       desc = "Create a new git worktree",
--     },
--   },
-- }
