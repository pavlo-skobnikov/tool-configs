return {
  { -- Pop up window pluing showing key mappings
    "folke/which-key.nvim",
    config = function()
      -- Set a delay for the popup to...well...pop up
      vim.o.timeout = true
      vim.o.timeoutlen = 200

      local which_key = require("which-key")

      -- Used only for setting groups
      which_key.register({
        f = { name = "find"},
        ["<space>"] = { name = "easy-motion"},
        t = { name = "toggle"},
        h = { name = "hunks"},
        g = {
          name = "git",
          d = { name = "diff" }
        },
        r = { name = "refactor", },
        w = { name = "workspace", },
      }, { prefix = "<leader>" })
    end,
  },
}
