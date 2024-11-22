-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cond = function()
      return require('custom.utils').is_neovim()
    end,
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>s,', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search neovim config' })

      local map = vim.keymap.set

      -- [[ LEADER ]] --------------------------------------------------------------------------------------------------
      map('n', "<leader>'", builtin.resume, { desc = 'Resume picker' })
      map('n', '<leader>:', builtin.commands, { desc = 'Commands' })
      map('n', '<leader>;', builtin.builtin, { desc = 'Telescope pickers' })

      -- [[ BUFFER ]] --------------------------------------------------------------------------------------------------
      map('n', '<leader>bb', builtin.buffers, { desc = 'Switch buffers' })
      map('n', '<leader><leader>', '<leader>bb', { desc = 'Switch buffers', remap = true })

      -- [[ FILE ]] ----------------------------------------------------------------------------------------------------
      map('n', '<leader>ff', builtin.find_files, { desc = 'Find file' })
      map('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })

      -- [[ GOTO ]] ----------------------------------------------------------------------------------------------------

      -- [[ INFO ]] ----------------------------------------------------------------------------------------------------
      -- Searching for things related to Neovim go here. Searching for things related to the code go in the Search keymap
      map('n', '<leader>ih', builtin.help_tags, { desc = 'Help tags' })
      map('n', '<leader>ij', builtin.jumplist, { desc = 'Jumplist' })
      map('n', '<leader>ik', builtin.keymaps, { desc = 'Keymaps' })
      map('n', '<leader>il', builtin.loclist, { desc = 'Location list' })
      map('n', '<leader>im', builtin.marks, { desc = 'Marks' })
      map('n', "<leader>i'", builtin.marks, { desc = 'Marks' })
      map('n', '<leader>ip', builtin.diagnostics, { desc = 'Problems/diagnostics' }) -- VSCode calls it problems
      map('n', '<leader>iq', builtin.quickfix, { desc = 'Quickfix' })
      map('n', '<leader>ir', builtin.registers, { desc = 'Registers' })
      map('n', '<leader>i"', builtin.registers, { desc = 'Registers' })

      -- [[ KUSTOMIZE ]] -----------------------------------------------------------------------------------------------

      -- [[ PROJECTS/FOLDERS/WORKSPACES ]] -----------------------------------------------------------------------------

      -- [[ SEARCH ]] --------------------------------------------------------------------------------------------------
      -- Searching for things related to the code go here. Searching for things related to Neovim go in the Help keymap
      map('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
      map('n', '<leader>sB', builtin.live_grep, { desc = 'Search all buffers' })
      map('n', '<leader>st', builtin.current_buffer_tags, { desc = "Search current buffer's tags" })
      map('n', '<leader>sT', builtin.tags, { desc = 'Search all tags' })
      map('n', '<leader>sv', '<Plug>(leader-vcs-map)/', { desc = 'Search Repo', remap = true, silent = true })
      map('n', '<leader>s.', builtin.grep_string, { desc = 'Search word at point(.)' })

      -- [[ VCS ]] -----------------------------------------------------------------------------------------------------
      map('n', '<leader>vf', function()
        if require('custom.utils.vcs').find_git_root() then
          return builtin.git_files()
        else
          return vim.cmd 'Telescope vim_p4_files'
        end
      end, { desc = 'VCS file' })
      map('n', '<leader>vc', builtin.git_bcommits, { desc = 'Buffer commits' })
      map('n', '<leader>vC', builtin.git_commits, { desc = 'All Commits' })
      map('n', '<leader>vs', builtin.git_status, { desc = 'Status' })
      map('n', '<leader>v?', builtin.git_status, { desc = 'Status' })
      map('n', '<leader>v/', function()
        if require('custom.utils.vcs').find_git_root() then
          vim.cmd 'LiveGrepGitRoot'
        end
      end, { desc = 'Search repo' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
