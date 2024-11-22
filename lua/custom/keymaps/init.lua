-- See `:help vim.keymap.set()`
local map = vim.keymap.set

-- REMAPPING -----------------------------------------------------------------------------------------------------------
-- Move by visual lines if count is not supplied. If a count is supplied then move by normal lines.
-- This makes it easy to supply a count to line-based operations such as yank/delete without worrying about visual lines
map({ 'n', 'v', 'o', 's', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ 'n', 'v', 'o', 's', 'x' }, 'gj', 'j')
map({ 'n', 'v', 'o', 's', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ 'n', 'v', 'o', 's', 'x' }, 'gk', 'k')

-- 'n' always searches forward and 'N' always searches backward
map({ 'n', 'v', 'o', 's', 'x' }, 'n', "v:searchforward == 1 ? 'n' : 'N'", { expr = true, desc = "'n' always searches forward" })
map({ 'n', 'v', 'o', 's', 'x' }, 'N', "v:searchforward == 1 ? 'N' : 'n'", { expr = true, desc = "'N' always searches back" })

-- Swap 'U' and 'C-R'
map('n', '<C-R>', 'U', { silent = true })
map('n', 'U', '<C-R>', { silent = true })

-- Remap 'w' to behave as 'w' should in all cases (:h cw). Use `ce` to do what `cw` used to
map('n', 'cw', 'dwi')
map('n', 'cW', 'dWi')

-- BUFFERS -------------------------------------------------------------------------------------------------------------
-- Switching buffers is something I do often, so make that as fast as possible
map('n', '<Leader><Leader>', '<Plug>(leader-buffer-map)b', { remap = true, silent = true })

-- INDENTATION AND STYLING ---------------------------------------------------------------------------------------------
-- Preserve visual block after indenting, increment/decrement
map('v', '>', '>gv')
map('v', '<', '<gv')

-- SEARCH AND REPLACE --------------------------------------------------------------------------------------------------
-- Use very-magic (PCRE-ish) while searching
map('n', '/', '/\\v')
map('n', '?', '?\\v')
map('c', '%s/', '%s/\\v')
map('c', '.s/', '.s/\\v')
map('x', ':s/', ':s/\\%V\\v')

-- Replace word under the cursor. Type replacement, press `<ESC>`. Use `.` to jump to next occurence and repeat
map('n', 'c*', '*<C-O>cgn')
map('n', 'cg*', 'g*<C-O>cgn')

-- MISC ----------------------------------------------------------------------------------------------------------------
-- Fill Text Width
map('n', '<Leader>mf', require('custom.utils').fill_width, { desc = 'Fill-width with character', silent = true })

if require('custom.utils').is_neovim() then
  require 'custom.keymaps.neovim-only'
end

if require('custom.utils').is_vscode() then
  require 'custom.keymaps.vscode-only'
end
