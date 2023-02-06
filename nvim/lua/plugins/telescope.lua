-- Description: Telescope configuration
return {
  { -- An incredibly extendable fuzzy finder over lists
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    cmd = { "Telescope", "Tel" }, -- Lazy loads on these commands
    keys = { "<leader>f" }, -- Lazy loads on this pattern
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = { -- Default Telescope configurations to be applied for all searches
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = {
            "truncate",
            truncate = 3
          },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

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
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

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
      })

      -- For access to Telescope function and further key map assignments
      local builtin = require('telescope.builtin')

      -- Telescope main commands
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find Text in Files" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Recent Buffer" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Documentation Help" })

      -- Git-related Telescope commands
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git Status" })
      vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = "Git Stash" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = " Git Commits" })
      vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = "Current File Commits" })

      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = " Branches" })
    end,
  },
  { -- UI picker extension for Telescope
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("ui-select")
    end,
  },
  { -- UI picker extension for DAP
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("dap")
    end,
  },
}

