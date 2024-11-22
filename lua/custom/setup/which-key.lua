local M = {}

function M.setup()
  require('which-key').add {
    { '<leader>b', group = 'Buffer' },
    { '<leader>c', group = 'Code' },
    { '<leader>f', group = 'File' },
    { '<leader>g', group = 'Goto' },
    { '<leader>h', group = 'Help' },
    { '<leader>i', group = 'Info' },
    { '<leader>k', group = 'Kustomize' },
    { '<leader>o', group = 'Open' },
    { '<leader>p', group = 'Project' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>v', group = 'VCS' },
    { '<leader>w', group = 'Window' },
  }
end

return M
