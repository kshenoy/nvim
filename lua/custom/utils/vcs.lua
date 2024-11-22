local M = {}

-- Get the  the current buffer's path as the starting point for the search
local function get_curr_dir()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    -- If the buffer is not associated with a file, try asking vim
    return vim.fn.getcwd()
  else
    -- Extract the directory from the current file's path
    return vim.fn.fnamemodify(current_file, ":h")
  end
end

-- Function to find the git root directory based on the current buffer's path
function M.find_git_root()
  local curr_dir = get_curr_dir()
  if not curr_dir then
    return nil
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(curr_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- Not a git repository
    return nil
  end
  return git_root
end

function M.find_p4_root()
  if not vim.fn.executable('p4') then
    return false
  end

  local curr_dir = get_curr_dir()
  if not curr_dir then
    return nil
  end

  -- require('plenary.job'):new({
  --   command = 'p4',
  --   args = { '--files' },
  --   cwd = vim.fn.getcwd(),
  --   env = { ['a'] = 'b' },
  --   on_exit = function(j, return_val)
  --     -- print(return_val)
  --     -- print(j:result())
  --   end,
  -- }):sync() -- or start()

  return false
end

return M
