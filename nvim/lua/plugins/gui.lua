-- Description: Configuration for the NeoVim editor GUI (if you can call it that)
return {
  { -- Colorscheme
    "navarasu/onedark.nvim",
    config = function()
      local theme = require("onedark")

      theme.load() -- Load the theme
    end
  },
  { -- Status Line
    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine = require("lualine")

      lualine.setup {
        options = {
          theme = "codedark"
        },

        inactive_sections = {
          -- Show inactive windows' number for easy switching
          lualine_a = {
            { function() return vim.api.nvim_win_get_number(0) end },
          }
        },
      }
    end,
  },
  { -- Terminal
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "ToggleTerm", "ToggleTermToggleAll" },
    keys = { "<C-\\>", "<C-S-\\>", "<space>\\" },
    config = function()
      local toggle_term = require("toggleterm")

      toggle_term.setup()

      local function append_user_term_num_input_to_cmd(cmd)
        return function()
          vim.cmd(":" .. cmd .. " " .. vim.fn.input({ "Terminal Number: " }) .. "<CR>")
        end
      end

      -- Toggling the terminal window
      vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle Terminal" })

      vim.keymap.set("n", "<C-S-\\>", ":ToggleTermToggleAll<CR>", { desc = "Toggle All Terminals" })
      vim.keymap.set("t", "<C-S-\\>", "<C-\\><C-n>:ToggleTermToggleAll<CR>", { desc = "Toggle All Terminals" })

      -- <leader> mappings for terminal
      -- Sending commands to terminal from the buffer
      vim.keymap.set("n", "<leader>\\l", ":ToggleTermSendCurrentLine<CR>",
        { desc = "Send Current Line to First Terminal" })
      vim.keymap.set("n", "<leader>\\L", append_user_term_num_input_to_cmd("ToggleTermSendCurrentLine"),
        { desc = "Send Current Line to Given Terminal" })

      vim.keymap.set("n", "<leader>\\s", ":ToggleTermSendVisualSelection<CR>",
        { desc = "Send Selection to First Terminal" })
      vim.keymap.set("n", "<leader>\\S", append_user_term_num_input_to_cmd("ToggleTermSendVisualSelection"),
        { desc = "Send Selection to Given Terminal" })

      -- Easier movement in terminal
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

    end,
  },
  { -- File Explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Remove legacy key bindings
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- Special symbols for diagnostics
      vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint" })

      -- Key bindings
      vim.keymap.set("n", "<leader>e", ":Neotree<CR>",
        { noremap = true, desc = "Open Explorer" })
      vim.keymap.set("n", "<leader>E", ":NeoTreeReveal<CR>",
        { noremap = true, desc = "Open Current File in Explorer" })

      -- Enable NeoTree
      require('neo-tree').setup {
        default_component_configs = {
          git_status = {
            symbols = {
              -- Custom git status type symbols
              untracked = "?", -- Had to change this from "" to "?" because it was causing issues
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
      }
    end
  },
  { -- Indentation guidelines
    "lukas-reineke/indent-blankline.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("indent_blankline").setup {
        indentLine_enabled = 1,

        filetype_exclude = {
          "help",
          "terminal",
          "alpha",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "",
        },
        buftype_exclude = { "terminal" },

        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = false,

        use_treesitter = true,
        use_treesitter_scope = true,
      }
    end,
  },
}
