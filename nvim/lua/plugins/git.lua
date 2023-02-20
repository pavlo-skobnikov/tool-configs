return {
  { -- Powerful Git wrapper for many-many simple and coml
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'Fugitive' })

      vim.keymap.set('n', '<leader>go', ':Git checkout<space>', { desc = 'Checkout Branch' })
      vim.keymap.set('n', '<leader>gp', ':Git pull<space>', { desc = 'Pull' })
      vim.keymap.set('n', '<leader>gP', ':Git push<space>', { desc = 'Push' })
    end,
  },
  { -- Great Git diff viewer
    'sindrets/diffview.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      -- Diff views
      vim.keymap.set(
        'n',
        '<leader>gd',
        ':DiffviewOpen<CR>',
        { desc = 'Open Project Diffs for Current Index' }
      )
      vim.keymap.set('n', '<leader>gD', ':DiffviewClose<CR>', { desc = 'Close Project Diffs' })

      -- Diff toggles
      vim.keymap.set(
        'n',
        '<leader>gh',
        ':DiffviewFileHistory<CR>',
        { desc = 'Browse Project Commit History' }
      )
      vim.keymap.set(
        'n',
        '<leader>gH',
        ':DiffviewFileHistory %<CR>',
        { desc = 'Current File Commit History' }
      )
    end,
  },
  { -- Git gutters and hunk navigation
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        on_attach = function()
          local gs = package.loaded.gitsigns

          -- Navigation
          vim.keymap.set('n', ']g', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Next Hunk' })

          vim.keymap.set('n', '[g', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Previous Hunk' })

          -- Actions
          vim.keymap.set(
            { 'n', 'v' },
            '<leader>hs',
            ':Gitsigns stage_hunk<CR>',
            { desc = 'Stage Hunk' }
          )
          vim.keymap.set(
            { 'n', 'v' },
            '<leader>hr',
            ':Gitsigns reset_hunk<CR>',
            { desc = 'Reset Hunk' }
          )
          vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo Stage Buffer' })
          vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
          vim.keymap.set('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end, { desc = 'Blame Line' })
          vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })

          -- Toggles
          vim.keymap.set(
            'n',
            '<leader>Tb',
            gs.toggle_current_line_blame,
            { desc = 'Toggle Current Line Blame' }
          )
          vim.keymap.set('n', '<leader>Td', gs.toggle_deleted, { desc = 'Toggle Deleted' })

          -- Text object
          vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      }
    end,
  },
}
