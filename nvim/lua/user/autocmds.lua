-- Description: This file contains all the autocommands for NeoVim to run on various events.
-- ASSIGNMENTS
local api = vim.api

local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

-- PREDICATES
local function file_should_be_edited()
  return (not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "")
end

-- FUNCTIONS
local function remove_trailing_white_spaces()
  vim.cmd [[%s/\s\+$//e]]
end

local function save_buffer()
  vim.api.nvim_command('silent update')
end

local function check_if_files_were_changed_outside_nvim()
  vim.cmd "checktime"
end

-- AUTOCMDS
-- -> look at `desc` field for more info
autocmd({ "BufWritePre" }, {
  group = augroup("RemoveTrailingWhiteSpaces", { clear = true }),
  pattern = { "*" },
  callback = function()
    if file_should_be_edited() then
      remove_trailing_white_spaces()
    end
  end,
  desc = "Remove trailing white spaces on saving",
})

autocmd({ "BufLeave", "FocusLost" }, {
  group = augroup("SaveBufferAutomatically", { clear = true }),
  pattern = { "*" },
  callback = function()
    if file_should_be_edited() then
      -- `pcall` is used to prevent errors from stopping the execution of the rest of the commands
      -- The calls may fail in some "special" buffers (like the one from `sindrets/diffview.nvim`)
      pcall(remove_trailing_white_spaces)
      pcall(save_buffer)
    end
  end,
  desc = "Remove trailing whitespaces and save buffer automatically on leaving it",
})

autocmd("FocusGained", {
  group = augroup("CheckFileForExternalChanges", { clear = true }),
  pattern = { "*" },
  callback = check_if_files_were_changed_outside_nvim,
  desc = "Update file when there are changes",
})

