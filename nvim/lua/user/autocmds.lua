local api = vim.api

local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

-- Remove trailing white spaces on saving
autocmd({ "BufWritePre" }, {
  group = augroup("RemoveTrailingWhiteSpaces", { clear = true }),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
