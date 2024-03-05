local function load_config(package)
  return function()
    require("plugins." .. package)
  end
end

-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

local plugins = {
  -- LazyVim for some nice utils and presets
  { "LazyVim/LazyVim" },
  -- UI
  { import = "plugins/ui/colorschemes" },
  { import = "plugins/ui/barbecue" },
  { import = "plugins/ui/lualine" },
  -- Tools
  { import = "plugins/tools/misc" },
  { import = "plugins/tools/telescope" },
  -- { import = "plugins/tools/nvim-tree" },
  { import = "plugins/tools/mini" },
  { import = "plugins/tools/neo-tree" },
  { import = "plugins/tools/spectre" },
  { import = "plugins/tools/flash" },
  { import = "plugins/tools/which-key" },
  -- Git
  { import = "plugins/git/gitsigns" },
  { import = "plugins/git/neogit" },
  -- Other
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
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
  -- Code
  { import = "plugins/code/treesitter" },
  { import = "plugins/lsp" },
  -- { import = "plugins/code/lsp" },

  { -- Show me what I did wrong
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-f>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
  {
    "github/copilot.vim",
    config = load_config("tools.copilot"),
    event = { "BufReadPre", "BufNewFile" },
  },
}

local ts_parsers = {
  --     'bash',
  --     'css',
  --     'elixir',
  --     'gitcommit',
  --     'go',
  --     'html',
  --     'java',
  --     'javascript',
  --     'json',
  "lua",
  --     'markdown',
  --     'markdown_inline',
  --     'python',
  --     'ruby',
  --     'rust',
  --     'typescript',
  --     'vim',
  --     'vimdoc',
  --     'yaml',
}

local lsp_servers = {
  --     'bashls',
  --     'eslint',
  --     'elixirls',
  --     'jsonls',
  "lua_ls",
  --     'ruby_ls',
  --     'ruff_lsp',
  --     'rubocop',
  --     'rust_analyzer',
  --     'tsserver',
  --     'typos_lsp',
  --     'vimls',
}

-- local null_ls_sources = {
--     'shellcheck',
-- }

return {
  plugins = plugins,
  ts_parsers = ts_parsers,
  lsp_servers = lsp_servers,
  -- null_ls_sources = null_ls_sources,
}
