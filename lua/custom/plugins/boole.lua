return {
  'nat-418/boole.nvim',

  -- Lazy-loading params
  cmd = 'Boole',
  keys = { '<C-a>', '<C-x>' },

  opts = {
    mappings = {
      increment = '<C-a>',
      decrement = '<C-x>',
    },
    additions = {
      { '.', '->', '::' },
    },
  },
}
