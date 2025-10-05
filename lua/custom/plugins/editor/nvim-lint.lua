return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      dockerfile = { 'hadolint' },
      ghaction = { 'actionlint' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      markdown = { 'markdownlint' },
      python = { 'djlint' },
      typescriptreact = { 'eslint_d' },
    }

    -- Args are `lint [...options]` by default. Insert `en-AU` (and `en-GB` as the fallback) as the
    -- locale, after the `lint` command.
    table.insert(lint.linters.cspell.args, 2, '--locale=en-AU,en-GB')

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then
          lint.try_lint()

          lint.try_lint 'cspell'
        end
      end,
    })
  end,
}
