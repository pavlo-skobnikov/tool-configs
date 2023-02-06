-- Description: Testing framework for NeoVim
return {
  { -- Awesome testing framework for NeoVim
    -- -> https://github.com/nvim-neotest/neotest
    "nvim-neotest/neotest",
    lazy = true,
    cmd = { "Neotest" },
    keys = { "<leader>t" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "pavlo-skobnikov/neotest-java-gradle",
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          require("neotest-java-gradle")
        }
      })

      vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "Run Nearest Test" })
      vim.keymap.set("n", "<leader>tR", function() neotest.run.run({ strategy = 'dap' }) end,
        { desc = "Run Nearest Test with DAP" })
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test Current File" })
      vim.keymap.set("n", "<leader>ts", function() neotest.run.stop() end, { desc = "Stop Test" })

      vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true, short = false }) end,
        { desc = "View Test Output" })
      vim.keymap.set("n", "<leader>tS", function() neotest.summary.toggle() end, { desc = "Test Suite Summary" })

      vim.keymap.set("n", "]t", function() neotest.jump.next({ status = 'failed' }) end,
        { desc = "Next Failed Test" })
      vim.keymap.set("n", "[t", function() neotest.jump.prev({ status = 'failed' }) end,
        { desc = "Previous Failed Test" })
    end
  }
}

