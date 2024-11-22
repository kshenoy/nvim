-- Set <space> as the leader key. See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Create some keymaps early so that they can be used by plugins
vim.keymap.set({'n', 'v'}, '<Leader>b', '<Plug>(leader-buffer-map)',     {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>c', '<Plug>(leader-code-map)',       {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>f', '<Plug>(leader-file-map)',       {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>g', '<Plug>(leader-goto-map)',       {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>h', '<Plug>(leader-help-map)',       {remap=true, silent=true})

-- Searching for editor-specific things go here eg. searching quickfix, locationlist etc.
-- Searching for things related to the code go in the Search keymap
vim.keymap.set({'n', 'v'}, '<Leader>i', '<Plug>(leader-info-map)',       {remap=true, silent=true})

-- This is for editor-specific settings. Editor-agnostic settings should go into the Toggle map
vim.keymap.set({'n', 'v'}, '<Leader>k', '<Plug>(leader-kustomize-map)',  {remap=true, silent=true})

vim.keymap.set({'n', 'v'}, '<Leader>o', '<Plug>(leader-open-map)',       {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>p', '<Plug>(leader-project-map)',    {remap=true, silent=true})

-- Searching for code-specific things go here.
-- Searching for things related to the editor go in the Info keymap eg. quickfix, locationlist etc.
vim.keymap.set({'n', 'v'}, '<Leader>s', '<Plug>(leader-search-map)',     {remap=true, silent=true})

-- This is for editor-agnostic settings. Editor-specific settings should go into the Kustom map
vim.keymap.set({'n', 'v'}, '<Leader>t', '<Plug>(leader-toggle-map)',     {remap=true, silent=true})

vim.keymap.set({'n', 'v'}, '<Leader>v', '<Plug>(leader-vcs-map)',        {remap=true, silent=true})
vim.keymap.set({'n', 'v'}, '<Leader>w', '<Plug>(leader-window-map)',     {remap=true, silent=true})
