return  {
  -- auto pairs
  "echasnovski/mini.pairs",
  config = function()
    require 'mini.pairs'.setup()
    vim.keymap.set('n', '<Plug>(leader-toggle-map)p',
      function()
        local Util = require("lazy.core.util")
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          Util.warn("Disabled auto pairs", { title = "Option" })
        else
          Util.info("Enabled auto pairs", { title = "Option" })
        end
      end,
      { desc = "Toggle auto pairs" }
    )
  end
}
