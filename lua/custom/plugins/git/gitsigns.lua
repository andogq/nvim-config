return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {},
  keys = {
    {
      '<leader>gs',
      function()
        local range = nil

        -- If in visual mode, only stage the selected lines.
        if vim.list_contains({ 'v', 'V', 'CTRL-V' }, vim.fn.mode()) then
          range = { vim.fn.line '.', vim.fn.line 'v' }
        end

        require('gitsigns').stage_hunk(range)
      end,
      mode = { 'n', 'v' },
      desc = '[S]tage hunk (toggle)',
    },
    {
      '<leader>gR',
      function()
        local range = nil

        -- If in visual mode, only stage the selected lines.
        if vim.list_contains({ 'v', 'V', 'CTRL-V' }, vim.fn.mode()) then
          range = { vim.fn.line '.', vim.fn.line 'v' }
        end

        require('gitsigns').reset_hunk(range)
      end,
      mode = { 'n', 'v' },
      desc = '[R]eset hunk',
    },
    {
      '<leader>ghp',
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      desc = '[H]unk [p]review',
    },
    {
      '<leader>gb',
      function()
        require('gitsigns').blame_line { full = true }
      end,
      desc = '[B]lame current line',
    },
    -- Hunk navigation
    {
      '[h',
      function()
        require('gitsigns').nav_hunk 'prev'
      end,
      desc = 'Jump to previous [h]unk (unstaged)',
    },
    {
      ']h',
      function()
        require('gitsigns').nav_hunk 'next'
      end,
      desc = 'Jump to next [h]unk (unstaged)',
    },
    {
      '[H',
      function()
        require('gitsigns').nav_hunk('prev', { target = 'all' })
      end,
      desc = 'Jump to previous [h]unk (all)',
    },
    {
      ']H',
      function()
        require('gitsigns').nav_hunk('next', { target = 'all' })
      end,
      desc = 'Jump to next [h]unk (all)',
    },
  },
}
