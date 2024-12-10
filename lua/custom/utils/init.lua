-- Collection of general utility functions
local M = {}

function M.is_neovim()
  return vim.fn.empty(vim.g.vscode) == 1
end

function M.is_vscode()
  return vim.fn.empty(vim.g.vscode) ~= 1
end

function M.prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  --Library failed to load, so perhaps return `nil` or something?
  return nil
end

function M.is_plugin_loaded(plugin)
  return vim.tbl_get(require('lazy.core.config').plugins, plugin) ~= nil
end

function M.toggle_opt(option)
  local o = vim.opt[option]
  if o._info.type == 'boolean' then
    vim.opt[option] = not o:get()
    vim.notify(o._info.name .. ' ' .. (o:get() and 'disabled' or 'enabled'))
  end
end

function M.fill_width()
  local fill_char = vim.fn.nr2char(vim.fn.getchar())
  local fill_amt = vim.o.textwidth - vim.api.nvim_get_current_line():len()
  local fill_str = string.rep(fill_char, fill_amt)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { fill_str })
end

return M
