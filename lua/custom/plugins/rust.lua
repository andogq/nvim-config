return {
    -- {
    --     "simrat39/rust-tools.nvim",
    --     lazy = true,
    --     opts = {
    --         tools = {
    --             on_initialized = function()
    --                 vim.cmd([[
    --                     augroup RustLSP
    --                         autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
    --                         autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
    --                         autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
    --                         autocmd BufWritePre                     *.rs silent! lua vim.lsp.buf.format()
    --                     augroup END
    --                 ]])
    --             end
    --         }
    --     },
    --     config = function() end,
    -- },
    -- {
    --     "neovim/nvim-lspconfig",
    --     opts = {
    --         servers = {
    --             rust_analyzer = {
    --                 keys = {
    --                     { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
    --                     { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
    --                     { "<leader>dR", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
    --                 },
    --                 settings = {
    --                     ["rust-analyzer"] = {
    --                         cargo = {
    --                             allFeatures = true,
    --                             loadOutDirsFromCheck = true,
    --                             runBuildScripts = true,
    --                         },
    --                         checkOnSave = {
    --                             allFeatures = true,
    --                             command = "clippy",
    --                             extraArgs = { "--no-deps" },
    --                         },
    --                         procMacro = {
    --                             enable = true,
    --                             ignored = {
    --                                 ["async-trait"] = { "async_trait" },
    --                                 ["napi-derive"] = { "napi" },
    --                                 ["async-recursion"] = { "async_recursion" },
    --                             }
    --                         }
    --                     }
    --                 }
    --             }
    --         },
    --         setup = {
    --             rust_analyzer = function(_, opts)
    --                 require("rust-tools").setup({ server = opts })
    --                 return true
    --             end
    --         },
    --     }
    -- },
    --
    -- {
    --     "simrat39/rust-tools.nvim",
    --     lazy = true,
    --     opts = function()
    --         local ok, mason_registry = pcall(require, "mason-registry")
    --         local adapter ---@type any
    --         if ok then
    --             -- rust tools configuration for debugging support
    --             local codelldb = mason_registry.get_package("codelldb")
    --             local extension_path = codelldb:get_install_path() .. "/extension/"
    --             local codelldb_path = extension_path .. "adapter/codelldb"
    --             local liblldb_path = ""
    --             if vim.loop.os_uname().sysname:find("Windows") then
    --                 liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    --             elseif vim.fn.has("mac") == 1 then
    --                 liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    --             else
    --                 liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    --             end
    --             adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    --         end
    --         return {
    --             dap = {
    --                 adapter = adapter,
    --             },
    --             tools = {
    --                 on_initialized = function()
    --                     vim.cmd([[
    --               augroup RustLSP
    --                 autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
    --                 autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
    --                 autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
    --               augroup END
    --             ]])
    --                 end,
    --             },
    --         }
    --     end,
    --     config = function() end,
    -- },
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        lazy = false,
        ft = { "rust" },
        opts = {
            server = {
                on_attach = function(client, bufnr)
                    local wk = require("which-key")
                    wk.register({
                        ["<leader>cR"] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
                        ["<leader>dr"] = { function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables" },
                    }, { mode = "n", buffer = bufnr })
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
                }
            }
        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("force",
                {},
                opts or {})
        end
    }
}
