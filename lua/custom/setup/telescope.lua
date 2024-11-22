local M = {}

function M.setup()
  local tb = require 'telescope.builtin'
  local wk = require 'which-key'

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    -- vim.keymap.set(mode, keys, func, { desc=desc })
    wk.add { keys, func, desc = desc, mode = mode }
  end

  -- [[ LEADER ]] ------------------------------------------------------------------------------------------------------
  map("<Leader>'", tb.resume, 'Resume picker')
  map('<Leader>:', tb.commands, 'Commands')
  map('<Leader>;', tb.builtin, 'Telescope pickers')

  -- [[ BUFFER ]] ------------------------------------------------------------------------------------------------------
  map('<leader>bb', tb.buffers, 'Switch buffers')

  -- FIXME: Hack till I figure out how to get which-key working with keymap prefix
  wk.add {
    { '<Leader><Leader>', '<Leader>bb', remap = true },
  }

  -- [[ FILE ]] --------------------------------------------------------------------------------------------------------
  map('<leader>ff', tb.find_files, 'Find file')
  map('<leader>fr', tb.oldfiles, 'Find recent files')

  -- [[ GOTO ]] --------------------------------------------------------------------------------------------------------
  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('<leader>gd', tb.lsp_definitions, 'Goto definition')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('<leader>gi', tb.lsp_implementations, 'Goto implementation')
  map('<leader>go', tb.lsp_document_symbols, 'Goto symbol (buffer)')
  map('<leader>gO', tb.lsp_workspace_symbols, 'Goto symbol (all buffers)')
  map('<leader>gr', tb.lsp_references, 'Goto references')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>gt', tb.lsp_type_definitions, 'Goto type-definition')

  -- [[ INFO ]] --------------------------------------------------------------------------------------------------------
  -- Searching for things related to Neovim go here. Searching for things related to the code go in the Search keymap
  map('<leader>ih', tb.help_tags, 'Search help tags')
  map('<leader>ij', tb.jumplist, 'Search jumps')
  map('<leader>ik', tb.keymaps, 'Search keymaps')
  map('<leader>il', tb.loclist, 'Search location-list')
  map('<leader>im', tb.marks, 'Search marks')
  map('<leader>ip', tb.diagnostics, 'Search problems/diagnostics') -- VSCode calls it problems
  map('<leader>iq', tb.quickfix, 'Search quickfix')
  map('<leader>ir', tb.registers, 'Search registers')

  -- [[ KUSTOMIZE ]] ---------------------------------------------------------------------------------------------------

  -- [[ PROJECTS/FOLDERS/WORKSPACES ]] ---------------------------------------------------------------------------------

  -- [[ SEARCH ]] ------------------------------------------------------------------------------------------------------
  -- Searching for things related to the code go here. Searching for things related to Neovim go in the Help keymap
  map('<leader>sb', tb.current_buffer_fuzzy_find, 'Search current buffer')
  map('<leader>sB', tb.live_grep, 'Search all buffers')
  map('<leader>ss', tb.symbols, 'Search symbols')
  map('<leader>st', tb.current_buffer_tags, "Search current buffer's tags")
  map('<leader>sT', tb.tags, 'Search all tags')
  wk.add { '<leader>sv', '<Plug>(leader-vcs-map)/', desc = 'Search VCS', remap = true, silent = true }
  map('<leader>s.', tb.grep_string, 'Search word at point(.)')

  -- [[ VCS ]] ---------------------------------------------------------------------------------------------------------
  map('<leader>vf', function()
    if require('custom.utils.vcs').find_git_root() then
      return tb.git_files()
    else
      return vim.cmd 'Telescope vim_p4_files'
    end
  end, 'VCS file')
  map('<leader>vc', tb.git_bcommits, 'Buffer commits')
  map('<leader>vC', tb.git_commits, 'All Commits')
  map('<leader>vs', tb.git_status, 'VCS Status')
  map('<leader>v/', function()
    if require('custom.utils.vcs').find_git_root() then
      vim.cmd 'LiveGrepGitRoot'
    end
  end, 'Search repo')
end

return M
