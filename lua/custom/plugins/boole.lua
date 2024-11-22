return {
  'nat-418/boole.nvim',
  opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
      },
      additions = {
        {'.', '->', '::'}
      },
  },
  -- Lazy-loading params
  cmd = 'Boole',
  keys = { '<C-a>', '<C-x>' },
}
