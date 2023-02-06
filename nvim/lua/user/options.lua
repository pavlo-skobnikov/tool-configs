-- Easier access vars
local o = vim.opt

local options = {
  backup = false,                          -- Creates a backup file
  clipboard = "unnamedplus",               -- Allows neovim to access the system clipboard
  cmdheight = 2,                           -- More space in the neovim command line for displaying messages
  completeopt = {
    "menu",
    "menuone",
    "noselect",
    "noinsert",
  },                                       -- A comma separated list of options for Insert mode completion
  conceallevel = 0,                        -- So that `` is visible in markdown files
  colorcolumn = '100',                     -- Visual marker for column width
  fileencoding = "utf-8",                  -- The encoding written to a file
  hlsearch = true,                         -- Highlight all matches on previous search pattern
  ignorecase = true,                       -- Ignore case in search patterns
  mouse = "a",                             -- Allow the mouse to be used in neovim
  pumheight = 10,                          -- Pop up menu height
  showmode = false,                        -- We don't need to see things like -- INSERT -- Anymore
  showtabline = 1,                         -- Show tabs only when there are more than one
  smartcase = true,                        -- Smart case
  smartindent = true,                      -- Make indenting smarter again
  splitbelow = true,                       -- Force all horizontal splits to go below current window
  splitright = true,                       -- Force all vertical splits to go to the right of current window
  swapfile = false,                        -- Creates a swapfile
  termguicolors = true,                    -- Set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- Enable persistent undo
  updatetime = 300,                        -- Faster completion (4000ms default)
  writebackup = false,                     -- If a file is being edited by another program (or was written to file
                                           --  while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- Convert tabs to spaces
  shiftwidth = 2,                          -- How much to (de-)indent when using `<` && `>` operators
  tabstop = 2,                             -- Insert 2 spaces for a tab
  cursorline = true,                       -- Highlight the current line
  number = true,                           -- Set numbered lines
  relativenumber = true,                   -- Set relative numbered lines
  numberwidth = 4,                         -- Set number column width to 2 {default 4}
  signcolumn = "yes",                      -- Always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- Display lines as one long line
  linebreak = true,                        -- Companion to wrap, don't split words
  list = true,                             -- Enable displaying hidden characters
  listchars = {
    tab = ">·",
    extends = '⟩',
    precedes = '⟨',
    trail = '·',
  },                                       -- Show hidden characters
  scrolloff = 8,                           -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- Minimal number of screen columns either side of cursor if wrap is `false`
  guifont = "monospace:h17",               -- The font used in graphical neovim applications
  whichwrap = "bs<>[]hl",                  -- Which "horizontal" keys are allowed to travel to prev/next line
  wildignorecase = true,                   -- When set case is ignored when completing file names and directories
  wildmode = "full",
}

for k, v in pairs(options) do
  o[k] = v
end

-- o.shortmess = "ilmnrx"                        -- Flags to shorten vim messages, see :help 'shortmess'
o.shortmess:append "c"                           -- Don't give |ins-completion-menu| messages
o.iskeyword:append "-"                           -- Hyphenated words recognized by searches
o.formatoptions:remove({ "c", "r", "o" })        -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

