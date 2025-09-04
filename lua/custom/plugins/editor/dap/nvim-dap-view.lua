return {
  'igorlfs/nvim-dap-view',
  ---@module 'dap-view'
  ---@type dapview.Config
  opts = {
    winbar = {
      default_section = 'scopes',
      sections = { 'console', 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'disassembly' },
    },
  },
}
