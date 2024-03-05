return {
  "folke/which-key.nvim",
  dependencies = { "lazyVim/LazyVim" },
  event = "VeryLazy",
  config = function()
    local Util = require("lazyvim.util")

    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    local icons = require("lib.icons")

    local setup = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 30,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      key_labels = {
        ["<leader>"] = icons.ui.Rocket .. "Space",
        ["<space>"] = icons.ui.Rocket .. "Space",
      },
      icons = {
        breadcrumb = icons.ui.ArrowOpen,
        separator = icons.ui.Arrow,
        group = "",
      },
      popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      window = {
        border = "none",
        position = "bottom",
        margin = { 0, 0, 0, 0 },
        padding = { 1, 2, 2, 2 },
        winblend = 30,
      },
      layout = {
        height = { min = 4, max = 24 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      ignore_missing = false,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
      show_help = true,
      show_keys = true,
      triggers = "auto",
      triggers_nowait = {
        -- marks
        "`",
        "'",
        "g`",
        "g'",
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
      },
      triggers_blacklist = {
        i = { "j", "j" },
        v = { "j", "j" },
      },
    }

    local i = {
      [" "] = "Whitespace",
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ["`"] = "Balanced `",
      ["("] = "Balanced (",
      [")"] = "Balanced ) including white-space",
      [">"] = "Balanced > including white-space",
      ["<lt>"] = "Balanced <",
      ["]"] = "Balanced ] including white-space",
      ["["] = "Balanced [",
      ["}"] = "Balanced } including white-space",
      ["{"] = "Balanced {",
      ["?"] = "User Prompt",
      _ = "Underscore",
      a = "Argument",
      b = "Balanced ), ], }",
      c = "Class",
      f = "Function",
      o = "Block, conditional, loop",
      q = "Quote `, \", '",
      t = "Tag",
    }

    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(" including.*", "")
    end

    local ic = vim.deepcopy(i)
    local ac = vim.deepcopy(a)

    for key, name in pairs({ n = "Next", l = "Last" }) do
      i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
      a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
    end

    local opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local mappings = {
      ["<tab>"] = { "<C-^>", "Alternate Buffer" },

      -- e = { "<cmd>NvimTreeToggle<cr>", icons.documents.OpenFolder .. "Explorer" },
      q = { "<cmd>q<cr>", icons.ui.Close .. "Quit" },
      Q = { "<cmd>qa!<cr>", icons.ui.Power .. "Force Quit!" },
      w = { "<cmd>w<cr>", icons.ui.Save .. "Save" },
      x = { "<cmd>x<cr>", icons.ui.Pencil .. "Write and Quit" },

      -- Harpoon quick keys
      ["1"] = {
        function()
          require("harpoon"):list():select(1)
        end,
        "which_key_ignore",
      },
      ["2"] = {
        function()
          require("harpoon"):list():select(2)
        end,
        "which_key_ignore",
      },
      ["3"] = {
        function()
          require("harpoon"):list():select(3)
        end,
        "which_key_ignore",
      },
      ["4"] = {
        function()
          require("harpoon"):list():select(4)
        end,
        "which_key_ignore",
      },
      a = {
        function()
          require("harpoon"):list():append()
        end,
        "which_key_ignore",
      },
      -- l = { function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, 'which_key_ignore' },

      b = {
        name = icons.ui.NewFile .. "Buffers",
        b = { "<cmd>Telescope buffers theme=ivy<cr>", "List Buffers" },

        -- name = icons.ui.Bug .. 'Debug',
        -- b = { '<cmd>DapToggleBreakpoint<cr>', 'Breakpoint' },
        -- c = { '<cmd>DapContinue<cr>', 'Continue' },
        -- i = { '<cmd>DapStepInto<cr>', 'Into' },
        -- l = { "<cmd>lua require'dap'.run_last()<cr>", 'Last' },
        -- o = { '<cmd>DapStepOver<cr>', 'Over' },
        -- O = { '<cmd>DapStepOut<cr>', 'Out' },
        -- r = { '<cmd>DapToggleRepl<cr>', 'Repl' },
        -- R = { '<cmd>DapRestartFrame<cr>', 'Restart Frame' },
        -- t = { '<cmd>DapUIToggle<cr>', 'Debugger' },
        -- x = { '<cmd>DapTerminate<cr>', 'Exit' },
      },
      -- c = {
      -- 	name = icons.ui.NeoVim .. "Config",
      -- 	c = { "<cmd>CccHighlighterToggle<cr>", "Colorize" },
      -- 	C = { "<cmd>CccConvert<cr>", "Convert Color" },
      -- 	d = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- 	e = { "<cmd>e ~/.config/nvim/init.lua<cr>", "Edit Config" },
      -- 	f = { "<cmd>!bundle exec rubocop -A %<cr>", "Format Files" },
      -- 	F = { "<cmd>retab<cr>", "Fix Tabs" },
      -- 	i = { vim.show_pos, "Inspect Position" },
      -- 	l = { "<cmd>:g/^\\s*$/d<cr>", "Clean Empty Lines" },
      -- 	n = { "<cmd>set relativenumber!<cr>", "Relative Numbers" },
      -- 	p = { "<cmd>CccPick<cr>", "Pick Color" },
      -- 	r = { "<cmd>Telescope reloader<cr>", "Reload Module" },
      -- 	R = { "<cmd>ReloadConfig<cr>", "Reload Configs" },
      -- },
      c = {
        name = icons.ui.Gear .. "Code",
        a = { vim.lsp.buf.code_action, "Code Action" },
        -- d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
        -- D = { "<cmd>Lspsaga goto_definition<cr>", "Goto Definition" },
        f = {
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end,
          "Format",
        },
        -- g = { "<cmd>Lspsaga finder<cr>", "Finder" },
        -- G = { "<cmd>Telescope lsp_references<cr>", "References" },
        -- h = { "<cmd>Lspsaga hover_doc<cr>", "Hover" },
        -- i = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        -- I = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Diagnostics" },
        -- j = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
        -- k = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
        -- l = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" },
        -- L = { "<cmd>LspInfo<cr>", "LSP Info" },
        -- o = { "<cmd>Lspsaga outline<cr>", "Outline" },
        -- p = { "<cmd>Telescope lsp_incoming_calls<cr>", "Incoming Calls" },
        -- P = { "<cmd>Telescope lsp_outgoing_calls<cr>", "Outgoing Calls" },
        -- r = { "<cmd>Lspsaga rename<cr>", "Rename" },
        -- R = { "<cmd>Lspsaga project_replace<cr>", "Replace" },
        -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        -- S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        -- t = { "<cmd>Lspsaga peek_type_definition<cr>", "Peek Type Definition" },
        -- T = { "<cmd>Lspsaga goto_type_definition<cr>", "Goto Type Definition" },
      },
      d = {
        name = icons.ui.Database .. "Database",
        b = { "<cmd>DBToggle<cr>", "DB Explorer" },
        j = { '<cmd>lua require("dbee").next()<cr>', "DB Next" },
        k = { '<cmd>lua require("dbee").prev()<cr>', "DB Prev" },
        s = { '<cmd>lua require("dbee").store("csv", "buffer", { extra_arg = 0 })<cr>', "To CSV" },
        S = { '<cmd>lua require("dbee").store("json", "buffer", { extra_arg = 0 })<cr>', "To JSON" },
        t = { '<cmd>lua require("dbee").store("table", "buffer", { extra_arg = 0 })<cr>', "To Table" },
      },
      e = {
        name = icons.ui.Bug .. "Errors",
        l = { "<cmd>TroubleToggle<cr>", "List" },
        n = { vim.diagnostic.goto_next, "Next" },
        p = { vim.diagnostic.goto_prev, "Prev" },
      },
      f = {
        name = icons.ui.Telescope .. "Find",
        b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
        B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        f = { "<cmd>Telescope find_files theme=ivy<cr>", "All Files" },
        c = { "<cmd>Telescope git_bcommits<cr>", "File Commits" },
        C = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
        -- e = { "<cmd>Oil<cr>", "Dir Editor" },
        g = { "<cmd>Telescope git_files<cr>", "Git files" },
        G = { "<cmd>Telescope grep_string<cr>", "Find Word" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        k = { "<cmd>Telescope commands<cr>", "Commands" },
        K = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        L = { "<cmd>Telescope loclist<cr>", "Location List" },
        n = { "<cmd>enew<cr>", "New File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
        p = { Util.telescope.config_files(), "Config Files" },
        q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
        -- s = { '<cmd>Telescope live_grep grep_open_files=true<cr>', 'Find in Open Files' },
        s = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        u = { "<cmd>Telescope undo<cr>", "Undo History" },
        ['"'] = { "<cmd>Telescope registers<cr>", "Registers" },
        ["."] = { "<cmd>Telescope symbols<cr>", "Emojis" },
        [","] = { "<cmd>Nerdy<cr>", "Nerd Glyphs" },
      },
      g = {
        name = icons.git.Octoface .. "Git",
        a = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
        A = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
        b = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
        c = { "<cmd>Git<cr>", "Commit" },
        C = { "<cmd>CoAuthor<cr>", "Add Co Author" },
        d = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
        D = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
        g = {
          function()
            require("neogit").open()
          end,
          "Neogit",
        },
        h = { "<cmd>Octo<cr>", "Octo" },
        j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
        R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
        s = { "<cmd>Telescope git_status<cr>", "Changed files" },
        S = { "<cmd>Telescope git_stash<cr>", "Stashed Changes" },
        t = {
          name = "Git Toggle",
          b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame" },
          d = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
          l = { "<cmd>Gitsigns toggle_linehl<cr>", "Line HL" },
          n = { "<cmd>Gitsigns toggle_numhl<cr>", "Number HL" },
          s = { "<cmd>Gitsigns toggle_signs<cr>", "Signs" },
          w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Word Diff" },
        },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
        v = { "<cmd>Gitsigns select_hunk<cr>", "Select Hunk" },
      },
      h = {
        name = icons.ui.Bookmark .. "Harpoon",
        ["1"] = {
          function()
            require("harpoon"):list():select(1)
          end,
          "Harpoon 1",
        },
        ["2"] = {
          function()
            require("harpoon"):list():select(2)
          end,
          "Harpoon 2",
        },
        ["3"] = {
          function()
            require("harpoon"):list():select(3)
          end,
          "Harpoon 3",
        },
        ["4"] = {
          function()
            require("harpoon"):list():select(4)
          end,
          "Harpoon 4",
        },
        a = {
          function()
            require("harpoon"):list():append()
          end,
          "Harpoon Add",
        },
        l = {
          function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
          end,
          "Harpoon List",
        },
        n = {
          function()
            require("harpoon"):list():prev()
          end,
          "Harpoon Next",
        },
        p = {
          function()
            require("harpoon"):list():next()
          end,
          "Harpoon Prev",
        },
      },
      m = {
        name = icons.kind.Field .. "Modes",
        d = { "<cmd>Dashboard<cr>", "Dashboard" },
        h = { "<cmd>Hardtime toggle<cr>", "Hardtime" },
        m = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview" },
        n = { "<cmd>Telescope notify<cr>", "Notifications" },
        r = { "<cmd>%SnipRun<cr>", "Run File" },
        s = { "<cmd>set spell!<cr>", "Spellcheck" },
        z = { "<cmd>ZenMode<cr>", "ZenMode" },
        Z = { "<cmd>Twilight<cr>", "Twilight" },
      },
      n = {
        name = icons.ui.Note .. "Notes",
        d = { "<cmd>Tdo<cr>", "Today's Todo" },
        e = { "<cmd>TdoEntry<cr>", "Today's Entry" },
        f = { "<cmd>TdoFiles<cr>", "All Notes" },
        g = { "<cmd>TdoFind<cr>", "Find Notes" },
        h = { "<cmd>Tdo -1<cr>", "Yesterday's Todo" },
        j = { "<cmd>put =strftime('%a %d %b %r')<cr>", "Insert Human Date" },
        J = { "<cmd>put =strftime('%F')<cr>", "Insert Date" },
        k = { "<cmd>put =strftime('%r')<cr>", "Insert Human Time" },
        K = { "<cmd>put =strftime('%F-%H-%M')<cr>", "Insert Time" },
        l = { "<cmd>Tdo 1<cr>", "Tomorrow's Todo" },
        n = { "<cmd>TdoNote<cr>", "New Note" },
        s = {
          '<cmd>lua require("tdo").run_with("commit " .. vim.fn.expand("%:p")) vim.notify("Committed!")<cr>',
          "Commit Note",
        },
        t = { "<cmd>TdoTodos<cr>", "Incomplete Todos" },
        x = { "<cmd>TdoToggle<cr>", "Toggle Todo" },
      },
      p = {
        name = icons.ui.Package .. "Packages",
        c = { "<cmd>Lazy check<cr>", "Check" },
        d = { "<cmd>Lazy debug<cr>", "Debug" },
        h = { "<cmd>Lazy<cr>", "Plugins" },
        m = { "<cmd>Mason<cr>", "Mason" },
        i = { "<cmd>Lazy install<cr>", "Install" },
        l = { "<cmd>Lazy log<cr>", "Log" },
        p = { "<cmd>Lazy profile<cr>", "Profile" },
        r = { "<cmd>Lazy restore<cr>", "Restore" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        u = { "<cmd>Lazy update<cr>", "Update" },
        x = { "<cmd>Lazy clean<cr>", "Clean" },
      },
      r = {
        name = icons.diagnostics.Hint .. "Refactor",
        b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
        e = { "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract Block" },
        f = { "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract To File" },
        i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
        n = { "", "Swap Next" },
        p = { "", "Swap Previous" },
        r = { "", "Smart Rename" },
        d = { "", "Go To Definition" },
        h = { "", "List Definition Head" },
        l = { "", "List Definition" },
        j = { "", "Next Usage" },
        k = { "", "Previous Usage" },
        R = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor Commands" },
        S = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Word" },
        v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
      },
      t = {
        name = icons.ui.Terminal .. "Terminal",
        ["`"] = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
        n = { "<cmd>Sterm node<cr>", "Node" },
        p = { "<cmd>Sterm bpython<cr>", "Python" },
        r = { "<cmd>Sterm irb<cr>", "Ruby" },
        s = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
        t = { "<cmd>Fterm<cr>", "Terminal" },
        v = { "<cmd>Vterm<cr>", "Vertical Terminal" },
      },
      T = {
        name = icons.ui.Test .. "Test",
        f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run Test" },
        F = { '<cmd>lua require("neotest").run.run()<cr>', "Run Current Test" },
        o = { "<cmd>Neotest output-panel<cr>", "Test Output" },
        O = { "<cmd>Neotest summary<cr>", "Test Summary" },
      },
      s = {
        name = icons.ui.Windows .. "Split",
        ["-"] = { "<C-w>s", "Split Below" },
        ["\\"] = { "<C-w>v", "Split Right" },
        c = { "<cmd>tabclose<cr>", "Close Tab" },
        d = { "<C-w>c", "Close Window" },
        f = { "<cmd>tabfirst<cr>", "First Tab" },
        h = { "<C-w>h", "Move Left" },
        j = { "<C-w>j", "Move Down" },
        k = { "<C-w>k", "Move Up" },
        l = { "<C-w>l", "Move Right" },
        L = { "<cmd>tablast<cr>", "Last Tab" },
        o = { "<cmd>tabnext<cr>", "Next Tab" },
        O = { "<cmd>tabprevious<cr>", "Previous Tab" },
        p = { "<C-w>p", "Previous Window" },
        q = { "<cmd>bw<cr>", "Close Current Buf" },
        s = { "<cmd>split<cr>", "Horizontal Split File" },
        t = { "<cmd>tabnew<cr>", "New Tab" },
        v = { "<cmd>vsplit<cr>", "Vertical Split File" },
        W = { "<cmd>lua require'utils'.sudo_write()<cr>", "Force Write" },
        w = { "<cmd>w<cr>", "Write" },
        x = { "<cmd>x<cr>", "Write and Quit" },
      },
      y = {
        name = icons.ui.Clipboard .. "Yank",
        f = { "<cmd>%y+<cr>", "Copy Whole File" },
        p = { "<cmd>CRpath<cr>", "Copy Relative Path" },
        P = { "<cmd>CApath<cr>", "Copy Absolute Path" },
        g = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', "Copy Git URL" },
      },
    }

    local vopts = {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local vmappings = {
      l = {
        name = icons.ui.Gear .. "LSP",
        a = "<cmd><C-U>Lspsaga range_code_action<CR>",
      },
      r = {
        name = icons.diagnostics.Hint .. "Refactor",
        r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor Commands" },
        e = { "<esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
        f = { "<esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "Extract To File" },
        v = { "<esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
        i = { "<esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
      },
      s = { "<esc><cmd>'<,'>SnipRun<cr>", icons.ui.Play .. "Run Code" },
      q = { "<cmd>q<cr>", icons.ui.Close .. "Quit" },
      Q = { "<cmd>qa!<cr>", icons.ui.Power .. "Force Quit!" },
      x = { "<cmd>x<cr>", icons.ui.Pencil .. "Write and Quit" },
      y = { '"+y', "Yank to clipboard" },
      -- y = {
      --   name = icons.ui.Clipboard .. "Yank",
      --   g = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', "Copy Git URL" },
      --   y = { '"+y', "Yank to clipboard" },
      -- },
    }

    local no_leader_opts = {
      mode = "n",
      prefix = "",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local no_leader_mappings = {
      ["<M-s>"] = { "<cmd>w<cr>", "Save buffer" },

      ["<S-h>"] = { "<cmd>bprevious<cr>", "Previous Buffer" },
      ["<S-l>"] = { "<cmd>bnext<cr>", "Next Buffer" },

      ["<S-F>"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },

      -- ['<C-h>'] = { '<C-w>h', 'Move Left' },
      -- ['<C-j>'] = { '<C-w>j', 'Move Down' },
      -- ['<C-k>'] = { '<C-w>k', 'Move Up' },
      -- ['<C-l>'] = { '<C-w>l', 'Move Right' },

      ["<C-Up>"] = { "<cmd>resize +10<cr>", "Increase window height" },
      ["<C-Down>"] = { "<cmd>resize -10<cr>", "Decrease window height" },
      ["<C-Left>"] = { "<cmd>vertical resize -10<cr>", "Decrease window width" },
      ["<C-Right>"] = { "<cmd>vertical resize +10<cr>", "Increase window width" },

      ["<M-.>"] = { vim.lsp.buf.code_action, "Code Action" },

      -- ['<C-f>'] = { '<cmd>Telescope find_files<cr>', 'Find Files' },
      -- ['<C-g>'] = { '<cmd>Fterm lazygit<cr>', 'Lazygit' },

      ["["] = {
        name = icons.ui.ArrowLeft .. "Previous",
        b = { "<cmd>bprevious<cr>", "Previous Buffer" },
        B = { "<cmd>bfirst<cr>", "First Buffer" },
        e = { "g;", "Previous Edit" },
        j = { "<C-o>", "Previous Jump" },
        h = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Prev Harpoon" },
      },
      ["]"] = {
        name = icons.ui.ArrowRight .. "Next",
        b = { "<cmd>bnext<cr>", "Next Buffer" },
        B = { "<cmd>blast<cr>", "Last Buffer" },
        e = { "g,", "Next Edit" },
        j = { "<C-i>", "Next Jump" },
        h = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Next Harpoon" },
      },

      ["#"] = { "<cmd>edit #<cr>", "Alternate Buffer" },
      K = { "<cmd>Lspsaga hover_doc<cr>", "LSP Hover" },
      U = { "<cmd>redo<cr>", "Redo" },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
    which_key.register(no_leader_mappings, no_leader_opts)
    which_key.register({ mode = { "o", "x" }, i = i, a = a })
  end,
}