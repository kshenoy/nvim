local M = {}

function M.setup(bufnr)
  local wk  = require('which-key')

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    -- vim.keymap.set(mode, keys, func, { desc=desc })
    wk.add({ keys, func, desc=desc, mode=mode, buffer=bufnr })
  end

  vim.keymap.set('n', "<C-k>", vim.lsp.buf.signature_help, { desc="Signature Documentation" })

  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, 'Remove folder from workspace')
  map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List folders in workspace")

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map("<leader>cr", vim.lsp.buf.rename, "Code Rename")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { 'n', 'x' })

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("<leader>gk", vim.lsp.buf.declaration, "Goto Declaration")
end

return M
