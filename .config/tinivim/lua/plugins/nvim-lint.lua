return {
  {
    "mfussenegger/nvim-lint",
    -- dependencies = {
    --   "folke/snacks.nvim",
    -- },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        terraform = { "tflint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft

      local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- vim.keymap.set("n", "<leader>cl", function()
      --   lint.try_lint()
      -- end, { desc = "lint" })

      -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      --   callback = function()
      --     -- try_lint without arguments runs the linters defined in `linters_by_ft`
      --     -- for the current filetype
      --     require("lint").try_lint()
      --   end,
      -- })
    end,
  },
}
