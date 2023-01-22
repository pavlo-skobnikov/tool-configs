return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      local term = require("toggleterm")

      term.setup()

      vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle Terminal"})
      vim.keymap.set("n", "<C-S-\\>", ":ToggleTermAll<CR>", { desc = "Toggle All Terminals"})
    end
  }
}
