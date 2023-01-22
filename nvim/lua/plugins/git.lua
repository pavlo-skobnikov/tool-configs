local map = vim.keymap.set

return {
  { -- Powerful Git wrapper for many-many simple and coml
    "tpope/vim-fugitive",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      map("n", "<leader>gg", ":Git<CR>", { desc = "Fugitive" })

      map("n", "<leader>gs", ":Telescope git_status", { desc = "Telescope Status"} )
      map("n", "<leader>gb", ":Telescope git_branches", { desc = "Branches"} )
      map("n", "<leader>gh", ":Telescope ", { desc = "Stash"} )
    end,
  },
  { -- Great Git diff viewer
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    config = function()
      -- Diff views
      map("n", "<leader>gdo", ":DiffviewOpen<CR>", { desc = "Open Project Diffs for Current Index" })
      map("n", "<leader>gdi", ":DiffviewOpen<CR>", { desc = "Open Project Diffs for Given Index" })
      map("n", "<leader>gdc", ":DiffviewClose<CR>", { desc = "Close Project Diffs" })

      -- Diff toggles
      map("n", "<leader>gdp", ":DiffviewFileHistory<CR>", { desc = "Browse Project Commit History" })
      map("n", "<leader>gdf", ":DiffviewFileHistory %<CR>", { desc = "Current File Commit History" })
    end,
  },
  { -- Git gutters and hunk navigation
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function()
         local gs = package.loaded.gitsigns

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr=true, desc = "Next Hunk" })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr=true, desc = "Previous Hunk" })

          -- Actions
          map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
          map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Buffer" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function() gs.blame_line{full=true} end, { desc = "Blame Line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })

          -- Toggles
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

          -- Text object
          map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end
      })
    end
  },
}
