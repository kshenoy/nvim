-- Define leader and some keymaps ahead of time.
-- This needs to be the first thing so that everything else can make use of it
require 'custom.keymaps.setup'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load kickstart
require 'kickstart.options'
require 'custom.options'

-- Now load the rest of my configuration.
-- [[ Install `lazy.nvim` plugin manager ]]
require 'kickstart.lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'kickstart.lazy-plugins'
-- Note that the package manager (lazy.nvim) automatically loads all the plugins specified in plugins
-- So I don't have to specify that explicitly

require 'custom.keymaps'
