-- Description: Plugin for dynamically showing key mappings
return {
  { -- The popup menu plugin
    'folke/which-key.nvim',
    config = function()
      -- Set a delay for the popup to...well...pop up
      vim.o.timeout = true
      vim.o.timeoutlen = 200

      local which_key = require 'which-key'

      -- Used only for setting groups
      which_key.register({
        ['<space>'] = { name = 'easy-motion' },
        ['\\'] = { name = 'terminal' },
        f = { name = 'find' },
        T = { name = 'toggle' },
        t = { name = 'tests' },
        h = { name = 'hunks' },
        g = { name = 'git' },
        p = { name = 'projects' },
        r = { name = 'replace' },
        w = { name = 'workspace' },
      }, { prefix = '<leader>' })
    end,
  },
}
