return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      local setup_toggle = function(key, cmd)
        local util = require 'lazy.core.util'
        local opt = 'mini' .. cmd .. '_disable'

        vim.keymap.set('n', '<Leader>t' .. string.lower(key), function()
          vim.b[opt] = not vim.b[opt]
          if vim.b[opt] then
            util.warn('Disabled ' .. cmd .. ' in current buffer', { title = 'Option' })
          else
            util.info('Enabled ' .. cmd .. ' in current buffer', { title = 'Option' })
          end
        end, { desc = 'Toggle mini-' .. cmd })

        vim.keymap.set('n', '<Leader>t' .. string.upper(key), function()
          vim.g[opt] = not vim.g[opt]
          if vim.g[opt] then
            util.warn('Disabled ' .. cmd, { title = 'Option' })
          else
            util.info('Enabled ' .. cmd, { title = 'Option' })
          end
        end, { desc = 'Toggle mini-' .. cmd .. ' (globally)' })
      end

      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsc', -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      if require('custom.utils').is_neovim() then
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return '%2l:%-2v'
        end
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      require('mini.align').setup()

      require('mini.basics').setup {
        options = {
          -- Extra UI features ('winblend', 'cmdheight=0', ...)
          extra_ui = true,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = 'default',
        },
        mappings = {
          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = '<Leader>t',
        },
      }

      require('mini.bracketed').setup {
        -- Replacing 'c' as it conflicts with gitsigns and vim's default movement in diffs
        -- 'gc' is a good alternative as it's also used as the 'comment' operator
        comment = { suffix = 'gc' },
        indent = { suffix = '' },
      }

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<Leader>bd', require('mini.bufremove').delete, { desc = 'Delete Buffer' })

      require('mini.indentscope').setup {
        symbol = '│',
      }
      vim.cmd 'highlight! link MiniIndentscopeSymbol Comment'
      setup_toggle('i', 'indentscope')

      -- Disable some operators as they're only marginally useful
      require('mini.operators').setup {
        evaluate = { prefix = '' },
        multiply = { prefix = '' },
        sort = { prefix = '' },
      }

      require('mini.pairs').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
