local M = {}

function M.setup(bufnr)
  local gs = package.loaded.gitsigns

  require('which-key').add({"<leader>vp", gs.preview_hunk, desc="Preview git hunk", buffer=bufnr})

  -- don't override the built-in and fugitive keymaps
  vim.keymap.set('v', ']c', function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })

  vim.keymap.set('v', '[c', function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
end

return M
