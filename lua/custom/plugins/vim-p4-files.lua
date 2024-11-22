return {
  'Badhi/vim-p4-files',
  cond = function()
    local utils = require 'custom.utils'
    return utils.is_neovim() and utils.prequire 'telescope'
  end,

  config = function()
    require('telescope').load_extension 'vim_p4_files'
  end,
}
