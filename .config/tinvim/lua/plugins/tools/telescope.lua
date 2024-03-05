return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-symbols.nvim",
    { "ThePrimeagen/harpoon", branch = "harpoon2" },
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end

    local actions = require("telescope.actions")
    -- local multi_open_mappings = require('plugins.tools.telescope-multiopen')
    local icons = require("lib.icons")

    telescope.setup({
      defaults = {
        layout_config = {
          height = 0.8,
          width = 0.9,
          prompt_position = "top",
          bottom_pane = {
            height = 0.5,
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
          },
          cursor = {
            preview_cutoff = 40,
            preview_width = 0.6,
          },
          horizontal = {
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          vertical = {
            preview_cutoff = 40,
          },
        },
        prompt_prefix = icons.ui.Telescope .. icons.ui.ChevronRight .. " ",
        selection_caret = icons.ui.Play,
        multi_icon = icons.ui.Check,
        path_display = { "smart" },
        sorting_strategy = "ascending",

        mappings = {
          i = {
            ["<esc>"] = actions.close,
            -- ['<C-n>'] = actions.cycle_history_next,
            -- ['<C-p>'] = actions.cycle_history_prev,

            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,
            ["<C-g>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            -- ['<C-s>'] = flash,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
          },

          n = {
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            -- ['s'] = flash,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      -- pickers = {
      --     find_files = { mappings = multi_open_mappings },
      --     git_files = { mappings = multi_open_mappings },
      --     oldfiles = { mappings = multi_open_mappings },
      -- },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        -- undo = {
        --     use_delta = true,
        --     use_custom_command = nil,
        --     side_by_side = true,
        --     diff_context_lines = vim.o.scrolloff,
        --     entry_format = 'state #$ID, $STAT, $TIME',
        --     -- time_format = '%d %b %H:%M',
        --     mappings = {
        --         i = {
        --             ['<S-cr>'] = require('telescope-undo.actions').yank_additions,
        --             ['<C-cr>'] = require('telescope-undo.actions').yank_deletions,
        --             ['<cr>'] = require('telescope-undo.actions').restore,
        --         },
        --     },
        -- },
        -- menufacture = { mappings = { main_menu = { [{ 'i', 'n' }] = '<C-,>' } } },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    -- require('telescope').load_extension('menufacture')
    -- require('telescope').load_extension('undo')
    -- require('telescope').load_extension('notify')
    -- require('telescope').load_extension('refactoring')
  end,
  cmd = "Telescope",
}
