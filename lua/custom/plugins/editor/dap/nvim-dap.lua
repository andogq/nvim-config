return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>dr',
      function()
        require('dap').continue()
      end,
      desc = '[R]un',
    },
    {
      '<leader>dc',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to [c]ursor',
    },
    {
      '<leader>dsi',
      function()
        require('dap').step_into()
      end,
      desc = 'Step [i]nside',
    },
    {
      '<leader>dsI',
      function()
        require('dap').step_into { steppingGranularity = 'instruction' }
      end,
      desc = 'Step [i]nstruction',
    },
    {
      '<leader>dso',
      function()
        require('dap').step_over()
      end,
      desc = 'Step [o]ver',
    },
    {
      '<leader>dsO',
      function()
        require('dap').step_out()
      end,
      desc = 'Step [o]ut',
    },
    {
      '<leader>dut',
      function()
        require('dap-view').toggle()
      end,
      desc = 'Debug UI [t]oggle',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Set [b]reakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Set conditional [b]reakpoint',
    },
    {
      '<leader>dCb',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Clear [b]reakpoints',
    },
  },
  config = function()
    local dap = require 'dap'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'codelldb',
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dap-view'] = function()
      require('dap-view').open()
    end
    dap.listeners.before.event_terminated['dap-view'] = function()
      require('dap-view').close()
    end
    dap.listeners.before.event_exited['dap-view'] = function()
      require('dap-view').close()
    end
  end,
}
