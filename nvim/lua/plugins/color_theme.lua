return {
  {
    "navarasu/onedark.nvim",
    config = function()
      local theme = require("onedark")

      theme.setup({
        style = "warm"
      })

      theme.load() -- Load the theme
    end
  },
}
