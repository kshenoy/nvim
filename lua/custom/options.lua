vim.opt.timeoutlen = 500 -- Kickstart's default is too low at 300ms

-- Neovim already has a lot of sane defaults. Here's some more.
if require('custom.utils').is_neovim() then
  -- [[ Moving around, searching and patterns ]] -----------------------------------------------------------------------
  vim.opt.autochdir = true -- change directory to file in window

  -- [[ Tags ]] --------------------------------------------------------------------------------------------------------
  vim.opt.tags = './tags;,./.tags;' -- list of file names to search for tags

  -- [[ Displaying text ]] ---------------------------------------------------------------------------------------------
  vim.opt.scrolloff = 6 -- no. of lines to show around the cursor for context
  vim.opt.showbreak = '↪' -- string to put at the start of wrapped lines
  vim.opt.sidescroll = 3 -- minimal number of columns to scroll horizontally
  vim.opt.sidescrolloff = 12 -- no. of columns to show around the cursor for context
  vim.opt.cmdheight = 2 -- number of screen lines to use for the command-line. Helps avoiding 'hit-enter' prompts
  vim.opt.listchars:append { extends = '›', precedes = '‹' } -- list of strings used for list mode
  vim.opt.number = false -- don't show line numbers
  vim.opt.conceallevel = 2 -- concealed text is completely hidden
  vim.opt.concealcursor = 'nc' -- conceal text in the cursor line in normal and command-line modes

  -- [[ Syntax, highlighting and spelling ]] ---------------------------------------------------------------------------
  vim.opt.hlsearch = true -- highlight all matches for the last used search pattern
  vim.opt.colorcolumn = '+1' -- highlight Column 121 (textwidth+1)
  -- Enable pre-Neovim 0.10 only as later versions have it smartly enabled
  if vim.fn.has 'nvim-0.10' == 0 then
    vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
  end

  -- [[ Multiple windows, tab pages ]] ---------------------------------------------------------------------------------
  vim.opt.laststatus = 3 -- enable global statusline

  -- [[ Editing text ]] ------------------------------------------------------------------------------------------------
  vim.opt.textwidth = 120 -- line length above which to break a line
  vim.opt.showmatch = true -- show matching brackets
  vim.opt.completeopt:append 'menuone' -- use the popup menu also when there is only one match
  vim.opt.completeopt:append 'noinsert' -- do not insert any text for a match until I select it
  vim.opt.completeopt:append 'noselect' -- do not select a match in the menu automatically

  -- [[ Tabs and indenting ]] ------------------------------------------------------------------------------------------
  vim.opt.expandtab = true -- expand <Tab> to spaces in Insert mode
  vim.opt.shiftwidth = 2 -- number of spaces used for each step of (auto)indent
  vim.opt.softtabstop = -1 -- Use value from shiftwidth
  vim.opt.shiftround = true -- round to 'shiftwidth' for "<<" and ">>"

  -- [[ Reading and writing files, swap file ]] ------------------------------------------------------------------------
  vim.opt.backup = true -- keep a backup after overwriting a file
  vim.opt.backupdir:remove '.' -- list of directories to put backup files in
  vim.opt.swapfile = false -- don't create swap files

  -- [[ Command line editing ]] ----------------------------------------------------------------------------------------
  vim.opt.suffixes:remove '.h' -- always show all .h files with :e
  vim.opt.wildmode = { 'longest:full', 'full' } -- insert longest match and show completions menu upon first Tab-press
  -- cycle through possible matches with consecutive Tab-presses

  -- [[ Running make and jumping to errors (quickfix) ]] ---------------------------------------------------------------
  if vim.fn.executable 'rg' then
    vim.opt.grepformat = '%f:%l:%m'
    vim.opt.grepprg = 'rg --vimgrep --smart-case'
  end
end
