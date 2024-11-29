return {
  'ggandor/leap.nvim',

  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward-to)', { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward-to)', { remap = true })
    if not vim.g.vscode then
      vim.keymap.set('n', '<M-s>', '<Plug>(leap-from-window)', { remap = true })
    end
  end,
}
