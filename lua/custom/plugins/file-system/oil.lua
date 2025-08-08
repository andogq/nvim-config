return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  keys = {
    {
      '-',
      desc = 'Open parent directory in oil.nvim',
      '<cmd>Oil<cr>',
    },
  },
}
