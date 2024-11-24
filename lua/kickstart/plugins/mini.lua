return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
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
      require('mini.surround').setup()

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
      require('mini.basics').setup({
        options = {
          -- Extra UI features ('winblend', 'cmdheight=0', ...)
          extra_ui = true,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = 'default',
        },
        mappings = {
          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = '<leader>t',

        },
      })
      require('mini.align').setup()
      require('mini.bracketed').setup()

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<Plug>(leader-buffer-map)d', require('mini.bufremove').delete, { desc = "Delete Buffer" })

      require('mini.operators').setup()
      require('mini.pairs').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
