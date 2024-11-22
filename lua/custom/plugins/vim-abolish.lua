-- Smarter abbrev, substitutes and case-coercions
-- Case-coercion
-- crs : snake_case
-- crm : MixedCase
-- crc : camelCase
-- cru : UPPER_CASE
-- cr- : dash-case
-- cr. : dot.case
return {
  'tpope/vim-abolish',
  -- enabled = false,

  -- This allows me to have the same keybinding between Neovim and VSCode
  init = function()
    vim.g.abolish_no_mappings = true
  end,
  config = function()
    vim.keymap.set('n', '<Plug>(leader-code-map)c', '<Plug>(abolish-coerce-word)')
    vim.keymap.set('v', '<Plug>(leader-code-map)c', '<Plug>(abolish-coerce)')
  end
}
