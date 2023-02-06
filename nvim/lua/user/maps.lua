function options(description)
  if description == nil
    then return { silent = true, noremap = false }
    else return { silent = true, noremap = false, desc = description } end
end

-- Shorten key mapping function name
local map = vim.keymap.set

--Remap space as leader key
-- map("", "<Space>", "<Nop>", options())
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes -> for reference
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal
-- Executing `x` on texts throws it into the void register
map("n", "x", '"_x', options())

-- Remove highlights on <ESC>
map("n", "<ESC>", ":noh<CR>", options())

-- Better window navigation
map("n", "<C-h>", "<C-w>h", options())
map("n", "<C-j>", "<C-w>j", options())
map("n", "<C-k>", "<C-w>k", options())
map("n", "<C-l>", "<C-w>l", options())

-- Resize with arrows
vim.cmd [[ nnoremap <C-S-k> :res -2<CR> ]]
vim.cmd [[ nnoremap <C-S-j> :res +2<CR> ]]
vim.cmd [[ nnoremap <C-S-l> :vertical res -2<CR> ]]
vim.cmd [[ nnoremap <C-S-h> :vertical res +2<CR> ]]

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", options())
map("n", "<S-h>", ":bprevious<CR>", options())

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", options())
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", options())

-- Insert
-- TODO: Add mappings for easy traversal in insert mode

-- Visual
-- Stay in indent mode
map("v", "<", "<gv", options())
map("v", ">", ">gv", options())

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", options())
map("v", "<A-k>", ":m .-2<CR>==", options())
map("v", "p", '"_dP', options())

-- Visual Block
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", options())
map("x", "K", ":move '<-2<CR>gv-gv", options())
map("x", "<A-j>", ":move '>+1<CR>gv-gv", options())
map("x", "<A-k>", ":move '<-2<CR>gv-gv", options())

-- Terminal
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

