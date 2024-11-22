return {
  'ggandor/leap.nvim',

  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-forward-to)', {remap=true})
    vim.keymap.set({'n', 'x', 'o'}, 'gS', '<Plug>(leap-backward-to)', {remap=true})
    if not vim.g.vscode then
      vim.keymap.set('n', 'g<C-s>', '<Plug>(leap-cross-window)', {remap=true})
    end
  end,
}
