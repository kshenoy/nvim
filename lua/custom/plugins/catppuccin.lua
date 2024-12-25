return { -- Colorscheme
  'catppuccin/nvim',
  name = 'catppuccin',

  cond = function()
    return require('custom.utils').is_neovim()
  end,

  config = function()
    vim.cmd 'colorscheme catppuccin-frappe'
  end,

  opts = {
    flavour = 'frappe', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    -- transparent_background = true,
    dim_inactive = {
      enabled = true,
    },
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      navic = { enabled = true, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
}
