return {
  'nvim-neotest/neotest',
  version = '^5',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = function()
    return {
      adapters = {
        require 'rustaceanvim.neotest',
      },
    }
  end,
  keys = {
    {
      '<leader>tw',
      function()
        require('neotest').watch.toggle(vim.fn.getcwd())
      end,
      desc = '[W]atch tests',
    },
    {
      '<leader>tr',
      function()
        require('neotest').run.run(vim.fn.getcwd())
      end,
      desc = '[R]un tests',
    },
    {
      '<leader>tfr',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[R]un file tests',
    },
    {
      '<leader>tfw',
      function()
        require('neotest').watch.toggle(vim.fn.expand '%')
      end,
      desc = '[W]atch file tests',
    },
    {
      '<leader>tcr',
      function()
        require('neotest').run.run()
      end,
      desc = '[R]un closest test',
    },
    {
      '<leader>tcw',
      function()
        require('neotest').watch.toggle()
      end,
      desc = '[W]atch closest test',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { suite = false, strategy = 'dap' }
      end,
      desc = '[D]ebug closest test',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle test [s]ummary window',
    },
  },
}
