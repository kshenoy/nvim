local augroup = vim.api.nvim_create_augroup('CustomAutocommands', { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Start builtin terminal in Insert mode',
  group = augroup,
  callback = vim.schedule_wrap(function(data)
    -- Try to start terminal mode only if target terminal is current
    if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then
      return
    end
    vim.cmd 'startinsert'
  end),
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'l*',
  desc = 'Auto-open LocationList after executing any quickfix cmd and hide filename, line and column info',
  group = augroup,
  callback = function()
    vim.cmd 'lopen'
    vim.cmd 'syntax match qfFileName /^[^|]*|[^|]*| / transparent conceal'
    vim.opt_local.wrap = false
    vim.cmd 'redraw!'
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  desc = 'Auto-open QuickFix after executing any quickfix cmd',
  group = augroup,
  callback = function()
    vim.cmd 'copen'
    vim.opt_local.wrap = false
    vim.cmd 'redraw!'
  end,
})
