return { -- Color scheme
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {},
  init = function()
    vim.cmd.colorscheme 'tokyonight-storm'
  end,
}
