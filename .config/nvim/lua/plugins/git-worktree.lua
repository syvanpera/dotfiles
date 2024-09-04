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
