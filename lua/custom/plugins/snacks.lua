return {
  'folke/snacks.nvim',
  opts = {
    explorer = {},
    notifier = {},
    picker = {
      sources = {
        explorer = {
          auto_close = true,
        },
      },
    },
  },
  keys = {
    -- Picker keys
    {
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Find [h]elp',
    },
    {
      '<leader>fk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Find [k]eymaps',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find [f]files',
    },
    {
      '<leader>fs',
      function()
        Snacks.picker.pickers()
      end,
      desc = 'Find [s]omething',
    },
    {
      '<leader>fw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Find [w]ord',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Find by [g]rep',
    },
    {
      '<leader>fd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Find [d]iagnostics',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Find [r]esume',
    },
    {
      '<leader>fn',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Find [n]otifications',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Find',
    },

    -- Picker git keys
    {
      '<leader>fGd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Find git [d]iff',
    },
    {
      '<leader>fGb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Find git [b]ranch',
    },
    {
      '<leader>fGl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Find git [l]og',
    },
    {
      '<leader>fGf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Find git log [f]ile',
    },
    {
      '<leader>fGL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Find git log [l]ine',
    },

    -- Picker LSP keys
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto [d]efinition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto [d]eclaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = 'Goto [r]eferences',
    },
    {
      'gi',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto [i]mplementation',
    },
    {
      'gt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto [t]ype definition',
    },
    {
      '<leader>fls',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Find LSP [s]ymbols',
    },
    {
      '<leader>flS',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Find LSP workspace [s]ymbols',
    },

    -- Explorer keys
    {
      '\\',
      function()
        Snacks.explorer.reveal()
      end,
    },
  },
}
