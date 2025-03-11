return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      -- { "github/copilot.vim" },
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      prompts = {
        Rename = {
          prompt = "Please rename the variable correctly in given selection based on context.",
          select = function(source)
            local select = require("CopilotChat.select")
            return select.visual(source)
          end,
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CopilotChat<CR>", mode = "n", desc = "copilot chat" },
      { "<leader>ax", "<cmd>CopilotChatExplain<CR>", mode = "v", desc = "explain code" },
      { "<leader>ar", "<cmd>CopilotChatReview<CR>", mode = "v", desc = "review code" },
      { "<leader>af", "<cmd>CopilotChatFix<CR>", mode = "v", desc = "fix code issues" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<CR>", mode = "v", desc = "optimize code" },
      { "<leader>ad", "<cmd>CopilotChatDocs<CR>", mode = "v", desc = "generate docs" },
      { "<leader>at", "<cmd>CopilotChatTests<CR>", mode = "v", desc = "generate tests" },
      { "<leader>ac", "<cmd>CopilotChatCommit<CR>", mode = { "n", "v" }, desc = "generate commit message" },
      { "<leader>az", "<cmd>CopilotChatRename<CR>", mode = "v", desc = "rename variable" },
    },
  },
}

