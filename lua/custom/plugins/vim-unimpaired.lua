return { -- Smarter abbrev, substitutes and case-coercions
  'tpope/vim-unimpaired',
  enabled = false,

  cond = function()
    return require('custom.utils').is_neovim()
  end,
}
