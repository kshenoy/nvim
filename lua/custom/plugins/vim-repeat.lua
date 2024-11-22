return {
  'tpope/vim-repeat',

  cond = function()
    return require('custom.utils').is_neovim()
  end,
}
