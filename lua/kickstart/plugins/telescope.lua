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
      local actions = require 'telescope.actions'
      local actions_layout = require 'telescope.actions.layout'
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            n = {
              ['<M-p>'] = actions_layout.toggle_preview,
            },
            i = {
              ['<M-f>'] = actions.to_fuzzy_refine, -- I use <C-Space> for TMUX so remap this
              ['<M-p>'] = actions_layout.toggle_preview,
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<M-d>'] = actions.delete_buffer + actions.move_to_top,
              },
            },
          },
        },
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
      vim.keymap.set('n', '<Leader>f,', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search neovim config' })

      local map = vim.keymap.set

      -- [[ LEADER ]] --------------------------------------------------------------------------------------------------
      map('n', "<Leader>'", builtin.resume, { desc = 'Resume picker' })
      map('n', '<Leader>:', builtin.commands, { desc = 'Commands' })
      map('n', '<Leader>;', builtin.builtin, { desc = 'Telescope pickers' })

      -- [[ BUFFER ]] --------------------------------------------------------------------------------------------------
      map('n', '<Leader>bb', builtin.buffers, { desc = 'Switch buffers' })

      -- [[ FILE ]] ----------------------------------------------------------------------------------------------------
      map('n', '<Leader>f.', function()
        builtin.find_files { cwd = vim.fn.expand '%:p:h' }
      end, { desc = 'Find files in current dir' })
      map('n', '<Leader>ff', builtin.find_files, { desc = 'Find file' })
      map('n', '<Leader>fr', builtin.oldfiles, { desc = 'Find recent files' })

      -- [[ GOTO ]] ----------------------------------------------------------------------------------------------------

      -- [[ INFO ]] ----------------------------------------------------------------------------------------------------
      -- Searching for neovim-related things go here. Searching for code-related things go in the Search keymap
      map('n', '<Leader>ih', builtin.help_tags, { desc = 'Help tags' })
      map('n', '<Leader>ij', builtin.jumplist, { desc = 'Jumplist' })
      map('n', '<Leader>ik', builtin.keymaps, { desc = 'Keymaps' })
      map('n', '<Leader>il', builtin.loclist, { desc = 'Location list' })
      map('n', '<Leader>im', builtin.marks, { desc = 'Marks' })
      map('n', "<Leader>i'", builtin.marks, { desc = 'Marks' })
      map('n', '<Leader>ip', builtin.diagnostics, { desc = 'Problems/diagnostics' }) -- VSCode calls it problems
      map('n', '<Leader>iq', builtin.quickfix, { desc = 'Quickfix' })
      map('n', '<Leader>ir', builtin.registers, { desc = 'Registers' })
      map('n', '<Leader>i"', builtin.registers, { desc = 'Registers' })

      -- [[ KUSTOMIZE ]] -----------------------------------------------------------------------------------------------

      -- [[ PROJECTS/FOLDERS/WORKSPACES ]] -----------------------------------------------------------------------------

      -- [[ SEARCH ]] --------------------------------------------------------------------------------------------------
      -- Searching for things related to the code go here. Searching for things related to Neovim go in the Help keymap
      map('n', '<Leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
      map('n', '<Leader>sB', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep (all buffers)',
        }
      end, { desc = 'Search all buffers' })
      map('n', '<Leader>s/', builtin.live_grep, { desc = 'Search all files' })
      map('n', '<Leader>st', builtin.current_buffer_tags, { desc = "Search current buffer's tags" })
      map('n', '<Leader>sT', builtin.tags, { desc = 'Search all tags' })
      map('n', '<Leader>sv', '<Leader>v/', { desc = 'Search Repo', remap = true, silent = true })
      map('n', '<Leader>s.', builtin.grep_string, { desc = 'Search word at point(.)' })

      -- [[ VCS ]] -----------------------------------------------------------------------------------------------------
      -- FIXME: Use 'on_attach' like gitsigns to allow it to be repo-specific
      map('n', '<Leader>vf', function()
        local vcs = require 'custom.utils.vcs'
        if vcs.is_git_repo() then
          return builtin.git_files()
        elseif vcs.is_p4_repo() then
          return vim.cmd 'Telescope vim_p4_files'
        else
          return builtin.find_files()
        end
      end, { desc = 'VCS file' })
      map('n', '<Leader>vc', builtin.git_bcommits, { desc = 'Buffer commits' })
      map('n', '<Leader>vC', builtin.git_commits, { desc = 'All Commits' })
      map('n', '<Leader>vs', builtin.git_status, { desc = 'Status' })
      map('n', '<Leader>v?', builtin.git_status, { desc = 'Status' })
      map('n', '<Leader>v/', function()
        local opts = {}
        local vcs = require 'custom.utils.vcs'
        local root = vcs.get_git_root() or vcs.get_p4_root()
        if root then
          opts = {
            cwd = root,
          }
        end
        require('telescope.builtin').live_grep(opts)
      end, { desc = 'Search repo' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
