return {
  'nanozuki/tabby.nvim',
  ---@type TabbyConfig
  opts = {
    preset = 'tab_only',
  },
  init = function()
    -- Always show tabline
    vim.o.showtabline = 2

    -- TODO: Move this to session manager
    vim.o.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
  end,
}
