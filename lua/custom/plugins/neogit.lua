return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      kind = 'floating',
      commit_editor = {
        kind = 'floating',
      },
    },
    keys = {
      {
        '<leader>g',
        function()
          require('neogit').open()
        end,
      },
    },
  },
}
