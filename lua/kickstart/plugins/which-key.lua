-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    cond = function()
      return require('custom.utils').is_neovim()
    end,
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      -- delay = 0,
      preset = 'helix',
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        {
          mode = { 'n', 'v' },
          { '<leader><tab>', group = 'Tabs' },
          {
            '<leader>b',
            group = 'Buffer',
            expand = function()
              return require('which-key.extras').expand.buf()
            end,
          },
          { '<leader>c', group = 'Code' },
          { '<leader>d', group = 'Debug' },
          { '<leader>dp', group = 'Profiler' },
          { '<leader>f', group = 'File/Find' },
          { '<leader>h', group = 'Help' },
          { '<leader>i', group = 'Info', icon = { icon = ' ', color = 'cyan' } },
          { '<leader>o', group = 'Open' },
          { '<leader>p', group = 'Project' },
          { '<leader>q', group = 'Quit/Session' },
          { '<leader>s', group = 'Search' },
          { '<leader>t', group = 'Toggle' },
          { '<leader>u', group = 'UI', icon = { icon = '󰙵 ', color = 'cyan' } },
          { '<leader>v', group = 'VCS', icon = { icon = ' ', color = 'orange' } },
          { '<leader>vh', group = 'Hunks' },
          {
            '<leader>w',
            group = 'Window/Workspace',
            proxy = '<c-w>',
            expand = function()
              return require('which-key.extras').expand.win()
            end,
          },
          { '<leader>x', group = 'Diagnostics/Quickfix', icon = { icon = '󱖫 ', color = 'green' } },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
          { 'gs', group = 'surround' },
          { 'z', group = 'fold' },
          -- better descriptions
          { 'gx', desc = 'Open with system app' },
          { "<leader>'", icon = { icon = ' ', color = 'blue' } },
          { '<leader>:', icon = { icon = '󰘳 ', color = 'blue' } },
        },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show { keys = '<c-w>', loop = true }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
