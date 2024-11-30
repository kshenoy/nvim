-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    cond = function()
      return require('custom.utils').is_neovim()
    end,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next change' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Previous change' })

        -- Actions
        -- visual mode
        map('v', '<Leader>vhs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage hunk' })
        map('v', '<Leader>vhr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset hunk' })

        -- normal mode
        map('n', '<Leader>vhs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<leader>vhr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        -- map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<Leader>vhS', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<Leader>vr', gitsigns.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<Leader>vhh', gitsigns.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<Leader>vb', gitsigns.blame_line, { desc = 'Blame line' })
        map('n', '<Leader>vd', gitsigns.diffthis, { desc = 'Diff against index' })
        map('n', '<Leader>vD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Diff against last commit' })

        -- Toggles
        map('n', '<Leader>vtd', gitsigns.toggle_deleted, { desc = 'Toggle show deleted' })
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
