-- See `:help vim.keymap.set()`

-- REMAPPING -----------------------------------------------------------------------------------------------------------
-- Move by visual lines if count is not supplied. If a count is supplied then move by normal lines.
-- This makes it easy to supply a count to line-based operations such as yank/delete without worrying about visual lines
-- - Don't map in Operator-pending mode because it severely changes behavior:
--   eg. `dj` on non-wrapped line will not delete it.
-- - `v:count == 0` makes it easier to use when using relative line numbers.
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'gj', 'j')
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'gk', 'k')

-- 'n' always searches forward and 'N' always searches backward
vim.keymap.set(
  { 'n', 'v', 'o', 's', 'x' },
  'n',
  "v:searchforward == 1 ? 'n' : 'N'",
  { expr = true, desc = "'n' always searches forward" }
)
vim.keymap.set(
  { 'n', 'v', 'o', 's', 'x' },
  'N',
  "v:searchforward == 1 ? 'N' : 'n'",
  { expr = true, desc = "'N' always searches back" }
)

-- Swap 'U' and 'C-R'
vim.keymap.set('n', '<C-R>', 'U', { silent = true })
vim.keymap.set('n', 'U', '<C-R>', { silent = true })

-- Remap 'w' to behave as 'w' should in all cases (:h cw). Use `ce` to do what `cw` used to
vim.keymap.set('n', 'cw', 'dwi')
vim.keymap.set('n', 'cW', 'dWi')

-- BUFFERS -------------------------------------------------------------------------------------------------------------
-- Switching buffers is something I do often, so make that as fast as possible
vim.keymap.set('n', '<Leader><Leader>', '<Leader>bb', { remap = true, silent = true })
vim.keymap.set('n', '<Leader>,', '<cmd>b#<CR>', { silent = true, desc = 'Alternate buffer' })

-- INDENTATION AND STYLING ---------------------------------------------------------------------------------------------
-- Preserve visual block after indenting, increment/decrement
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- SEARCH AND REPLACE --------------------------------------------------------------------------------------------------
-- Use very-magic (PCRE-ish) while searching
-- vim.keymap.set('n', '/', '/\\v')
-- vim.keymap.set('n', '?', '?\\v')
-- vim.keymap.set('c', '%s/', '%s/\\v')
-- vim.keymap.set('c', '.s/', '.s/\\v')
-- vim.keymap.set('x', ':s/', ':s/\\%V\\v')

-- Replace word under the cursor. Type replacement, press `<ESC>`. Use `.` to jump to next occurence and repeat
vim.keymap.set('n', 'c*', '*<C-O>cgn')
vim.keymap.set('n', 'cg*', 'g*<C-O>cgn')

-- MISC ----------------------------------------------------------------------------------------------------------------
-- Fill Text Width
vim.keymap.set(
  'n',
  '<Leader>mf',
  require('custom.utils').fill_width,
  { desc = 'Fill-width with character', silent = true }
)

-- Add empty lines before/after cursor line
vim.keymap.set(
  'n',
  'gO',
  "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
  { desc = 'Add empty line above' }
)
vim.keymap.set(
  'n',
  'go',
  "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
  { desc = 'Add empty line below' }
)

if require('custom.utils').is_neovim() then
  require 'custom.keymaps.neovim-only'
end

if require('custom.utils').is_vscode() then
  require 'custom.keymaps.vscode-only'
end
