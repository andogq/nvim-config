return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      '-',
      desc = 'Open parent directory in oil.nvim',
      '<cmd>Oil<cr>',
    },
  },
}
