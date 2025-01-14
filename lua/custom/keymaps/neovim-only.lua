-- [[ REMAPS ]] --------------------------------------------------------------------------------------------------------
-- Display full path and filename
vim.keymap.set('n', '<C-G>', '2<C-G>')

-- Remap `ZQ` to quit everything. I can always use `:bd` to delete a single buffer
vim.keymap.set('n', 'ZQ', '<Cmd>qall!<CR>')

-- Copy the file name to unix visual select buffer
vim.keymap.set('n', '<Leader>fy', function()
  vim.cmd('let @+="' .. vim.fn.expand '%:p' .. '"')
end, { desc = 'Copy file path' })

-- [[ FILE ]]-----------------------------------------------------------------------------------------------------------
--[[
local fzf_lua_p4 = require('neovim-only.fzf-lua.perforce')

-- Checkout the file if in a VCS
map('n', '<Leader>ve', function()
  if fzf_lua_p4.is_p4_repo({}, true) then
    vim.cmd "!p4 edit %"
  end
end, {desc = "Checkout file"})


map('n', '<Leader>vs', function()
  if require('fzf-lua.path').is_git_repo({}, true) then
    return require('fzf-lua').git_status()
  elseif fzf_lua_p4.is_p4_repo({}, true) then
    return fzf_lua_p4.status()
  end
end, {desc="Repo status"})
]]
--

-- [[ TOGGLES ]] -------------------------------------------------------------------------------------------------------
local mapt = function(key, option)
  vim.keymap.set(
    'n',
    '<leader>t' .. key,
    '<Cmd>set ' .. option .. '! ' .. option .. '?<CR>',
    { desc = 'Toggle ' .. option }
  )
end
mapt('c', 'cursorline')
mapt('C', 'cursorcolumn')
mapt('l', 'list')
mapt('n', 'number')
mapt('N', 'relativenumber')
mapt('s', 'spell')
mapt('w', 'wrap')

-- [[ MISC ]] ----------------------------------------------------------------------------------------------------------
vim.keymap.set('n', '<Leader>ul', function()
  if (vim.fn.getloclist(0, { winid = 0 }).winid or 0) == 0 then
    vim.cmd 'lopen'
  else
    vim.cmd 'lclose'
  end
end, { desc = 'Toggle LocationList' })

vim.keymap.set('n', '<Leader>uq', function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if (win.quickfix == 1) and (win.loclist == 0) then
      vim.cmd 'cclose'
      return
    end
  end
  vim.cmd 'copen'
end, { desc = 'Toggle QuickFix' })

-- Window resize (respecting `v:count`)
vim.keymap.set(
  'n',
  '<C-W><',
  '"<Cmd>vertical resize -" . 3*v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Decrease window width' }
)
vim.keymap.set(
  'n',
  '<C-W>>',
  '"<Cmd>vertical resize +" . 3*v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Increase window width' }
)
vim.keymap.set(
  'n',
  '<C-W>-',
  '"<Cmd>resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Decrease window height' }
)
vim.keymap.set(
  'n',
  '<C-W>+',
  '"<Cmd>resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Increase window height' }
)

-- Evaluate expressions
vim.keymap.set('n', '<Leader>x<Leader>', '<cmd>source %<CR>', { desc = 'Evaluate buffer' })
vim.keymap.set('n', '<Leader>xx', ':.lua<CR>', { desc = 'Evaluate current line' })
vim.keymap.set('v', '<Leader>xx', ':lua<CR>', { desc = 'Evaluate selection' })

-- NOTE: This may not work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Open diagnostics in location-list' })
