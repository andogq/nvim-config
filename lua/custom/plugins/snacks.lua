IGNORE_GLOBS = {
  '**/*.lock',
  '**/package-lock.json',
}

return {
  'folke/snacks.nvim',
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    explorer = {},
    gitbrowse = {},
    indent = {},
    notifier = {},
    picker = {
      main = {
        -- Allow any window to be used as the main window.
        current = true,
      },
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          ignored = false,
        },
        files = {
          hidden = true,
          ignored = false,
        },
      },
    },
  },
  keys = {
    -- Explorer keys
    {
      '\\',
      function()
        Snacks.explorer.reveal()
      end,
    },

    -- Git browse keys
    {
      '<leader>gob',
      function()
        Snacks.gitbrowse.open { what = 'branch' }
      end,
      desc = 'Open [b]ranch in browser',
    },
    {
      '<leader>goc',
      function()
        -- NOTE: This is copied from `snacks.nvim/lua/snacks/gitbrowse.lua`
        local function get_commit()
          -- Get the file and directory inforamtion
          local file = vim.api.nvim_buf_get_name(0) ---@type string?
          file = file and (vim.uv.fs_stat(file) or {}).type == 'file' and svim.fs.normalize(file) or nil
          local cwd = file and vim.fn.fnamemodify(file, ':h') or vim.fn.getcwd()

          -- Query git to determine the last commit in the file
          local git_output = vim.fn.system({ 'git', '-C', cwd, 'log', '-n', '1', '--pretty=format:%H', '--', file }, 'Failed to get latest commit of file')
          local commit = vim.split(vim.trim(git_output), '\n')[1]

          return commit
        end

        -- NOTE: This is copied from https://github.com/folke/snacks.nvim/discussions/1970#discussioncomment-13452975
        local function open_commit(commit)
          -- `gitbrowse` uses `vim.fn.expand` to expand the word under the cursor to check if it's
          -- a commit hash. This function is patched so that it returns the determined commit hash
          -- instead.
          local expand = vim.fn.expand
          vim.fn.expand = function(what, ...) ---@diagnostic disable-line
            if what == '<cword>' then
              return commit or expand(what, ...)
            end

            return expand(what, ...)
          end

          -- Call out to the real implementation
          Snacks.gitbrowse.open { what = 'commit' }

          -- Restore the patch
          vim.fn.expand = expand
        end

        local commit = get_commit()
        open_commit(commit)
      end,
      desc = 'Open [c]ommit in browser',
    },
    {
      '<leader>gof',
      function()
        Snacks.gitbrowse.open { what = 'file' }
      end,
      desc = 'Open [f]ile in browser',
    },
    {
      '<leader>gol',
      function()
        Snacks.gitbrowse.open { what = 'permalink' }
      end,
      desc = 'Open [l]ink in browser',
    },
    {
      '<leader>gor',
      function()
        Snacks.gitbrowse.open { what = 'repo' }
      end,
      desc = 'Open [r]epo in browser',
    },

    -- Notifier keys
    {
      '<leader>nc',
      function()
        Snacks.notifier.hide()
      end,
      desc = '[C]lear notification',
    },

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
        Snacks.picker.grep_word { exclude = IGNORE_GLOBS }
      end,
      desc = 'Find [w]ord',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.grep { exclude = IGNORE_GLOBS }
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
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Find [p]rojects',
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
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'Find LSP workspace [s]ymbols',
    },
    {
      '<leader>flS',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Find LSP [s]ymbols',
    },
  },
}
