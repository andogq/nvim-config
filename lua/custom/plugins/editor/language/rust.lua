return {
  'mrcjkb/rustaceanvim',
  version = '^7',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            files = {
              -- Rustaceanvim sets this as `server` by default in [1], in an attempt to fix mrcjkb/rustaceanvim#423. It claims to
              -- do this if nvim's file watcher isn't enabled, however it seems to be missing a negation. This is potentially a
              -- bug within rustaceanvim.
              --
              -- [1]: https://github.com/mrcjkb/rustaceanvim/blob/eb606eb3785f6c6e31ef675c32b706694b76923b/lua/rustaceanvim/lsp/init.lua#L88.
              -- Related PR: https://github.com/mrcjkb/rustaceanvim/pull/427
              watcher = 'client',
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            check = {
              features = 'all',
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    }
  end,
  keys = {
    {
      '<leader>rs',
      desc = 'Select Rust Runnable',
      function()
        vim.cmd.RustLsp 'runnables'
      end,
    },
    {
      '<leader>rr',
      desc = 'Run Last Rust Runnable',
      function()
        vim.cmd.RustLsp { 'runnables', bang = true }
      end,
    },
    {
      '<leader>rc',
      desc = 'Run Target from Cursor',
      function()
        vim.cmd.RustLsp 'run'
      end,
    },
    {
      '<leader>rd',
      desc = 'Open docs.rs for symbol at cursor',
      function()
        vim.cmd.RustLsp 'openDocs'
      end,
    },
  },
}
