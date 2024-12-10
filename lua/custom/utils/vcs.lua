local M = {}

-- Get the current buffer's path as the starting point for the search
local function get_curr_dir()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    -- If the buffer is not associated with a file, try asking vim
    return vim.fn.getcwd()
  else
    -- Extract the directory from the current file's path
    return vim.fn.fnamemodify(current_file, ':h')
  end
end

-- Check if we're in a git repo based on the current buffer's path
function M.is_git_repo()
  local curr_dir = get_curr_dir()
  if not curr_dir then
    return false
  end
  vim.fn.system('git -C ' .. vim.fn.escape(curr_dir, ' ') .. ' rev-parse --is-inside-work-tree')
  return vim.v.shell_error == 0
end

-- Find the git root directory based on the current buffer's path
function M.get_git_root()
  if M.is_git_repo() then
    return vim.fn.systemlist('git -C ' .. vim.fn.escape(curr_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  end
  return nil
end

-- Check if we're in a git repo based on the current buffer's path
function M.is_p4_repo()
  -- Can't determine if we don't have the 'p4' command
  if not vim.fn.executable 'p4' then
    return false
  end
  vim.fn.system('p4 -F %client% info')
  return vim.v.shell_error == 0
end

function M.get_p4_root()
  if M.is_p4_repo() then
    return vim.fn.systemlist('p4 -F %clientRoot% -ztag info')[1]
  end
  return nil
end

return M
