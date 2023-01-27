return {
  {
    "navarasu/onedark.nvim",
    config = function()
      local theme = require("onedark")

      theme.load() -- Load the theme
    end
  },
}
