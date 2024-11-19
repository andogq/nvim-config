return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        lazy = false,
        ft = { "rust" },
        opts = {
            server = {
                on_attach = function(client, bufnr)
                    vim.g.ando.on_attach(client, bufnr)

                    local wk = require("which-key")
                    wk.add(
                        {
                            { "<leader>cR", function() vim.cmd.RustLsp("codeAction") end,  buffer = bufnr, desc = "Code Action" },
                            { "<leader>dr", function() vim.cmd.RustLsp("debuggables") end, buffer = bufnr, desc = "Rust debuggables" },
                        }
                    )

                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        -- Add clippy lints for Rust.
                        checkOnSave = {
                            allFeatures = true,
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    }
                },
                load_vscode_settings = true,
            }
        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("force",
                {},
                opts or {})
        end
    }
}
