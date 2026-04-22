-- Core plugins ===============================================================
Config.now(function()
    -- HACK: Both these plugins modify `$PATH`, and they interfere with each other.
    vim.pack.add({ "https://plugins.ejri.dev/mise.nvim", "https://github.com/mason-org/mason.nvim" })
    require("mason").setup()
    require("mise").setup()
end)

-- Core language support ======================================================
Config.now(function()
    Config.on_package_change("nvim-treesitter", { "update" }, function() vim.cmd("TSUpdate") end, ":TSUpdate")
    vim.pack.add({
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    })

    local treesitter = require("nvim-treesitter")

    local ensure_languages = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "go",
        "html",
        "htmldjango",
        "javascript",
        "json",
        "python",
        "regex",
        "rst",
        "rust",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "typescriptreact",
        "yaml",
    }

    -- Install all required parsers
    treesitter.install(ensure_languages, { summary = true })

    -- Enable parser on buffer attach
    Config.new_autocmd("FileType", ensure_languages, function() vim.treesitter.start() end)
end)

Config.now(function()
    vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

    vim.lsp.enable({
        "html",
        "jsonls",
        "lua_language_server",
        "postgres_lsp",
        "rust_analyzer",
        "svelte",
        "ts_ls",
    })
end)

-- Other language support =====================================================
Config.later(function()
    vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

    local js_formatters = { "eslint_d", "prettierd" }

    require("conform").setup({
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            cpp = { "clang-format" },
            lua = { "stylua" },

            javascript = js_formatters,
            javascriptreact = js_formatters,
            svelte = js_formatters,
            typescript = js_formatters,
            typescriptreact = js_formatters,
        },
        format_on_save = {
            lsp_format = "fallback",
            timeout_ms = 1000,
        },
    })
end)

Config.later(function()
    vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

    local lint = require("lint")
    lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        ghaction = { "actionlint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        markdown = { "markdownlint" },
        python = { "djlint" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
    }

    Config.new_autocmd("BufWritePost", "*", function()
        if vim.bo.modifiable then lint.try_lint() end
    end, "nvim-lint on write")
end)

Config.later(function() vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" }) end)

-- Editor =====================================================================
Config.later(function()
    vim.pack.add({ "https://github.com/folke/flash.nvim" })
    require("flash").setup({
        modes = {
            search = {
                enabled = true, -- Use flash to augment searching with `/` and `?`
            },
        },
    })
end)

-- Terminal ===================================================================
Config.now(function()
    vim.pack.add({ "https://github.com/willothy/flatten.nvim" })
    require("flatten").setup({
        nest_if_no_args = true,
        nest_if_cmds = true,
    })
end)

-- UI =========================================================================
Config.later(function()
    vim.pack.add({ "https://github.com/mrjones2014/smart-splits.nvim" })
    require("smart-splits").setup()
end)
