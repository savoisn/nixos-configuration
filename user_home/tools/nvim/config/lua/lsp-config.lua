-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('illuminate').on_attach(client)

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = true }
    require('legendary').keymaps({
        { 'gD', vim.lsp.buf.declaration,    description = 'LSP: Go to declaration',    opts = opts },
        { 'gd', vim.lsp.buf.definition,     description = 'LSP: Go to definition',     opts = opts },
        { 'K',  vim.lsp.buf.hover,          description = 'LSP: Hover',                opts = opts },
        { 'gi', vim.lsp.buf.implementation, description = 'LSP: Go to implementation', opts = opts },
        {
            '<C-s>',
            vim.lsp.buf.signature_help,
            description = 'LSP: Signature help',
            mode = { 'n',
                'i' },
            opts =
                opts
        },
        { '<space>wa', vim.lsp.buf.add_workspace_folder,    description = 'LSP: Add workspace folder',    opts = opts },
        { '<space>wr', vim.lsp.buf.remove_workspace_folder, description = 'LSP: Remove workspace folder', opts = opts },
        {
            '<space>wl',
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            description = 'LSP: List workspaces',
            opts = opts
        },
        { '<space>D',  vim.lsp.buf.type_definition, description = 'LSP: Show type definition', opts = opts },
        { '<space>rn', vim.lsp.buf.rename,          description = 'LSP: Rename',               opts = opts },
        { '<space>ca', vim.lsp.buf.code_action,     description = 'LSP: Code Action',          opts = opts },
        { 'gr',        vim.lsp.buf.references,      description = 'LSP: Show references',      opts = opts },
        {
            '<space>e',
            function() vim.diagnostic.open_float(0, { scope = "line" }) end,
            description = 'Diagnostics: Show window',
            opts = opts
        },
        {
            '[d',
            function() vim.diagnossic.goto_prev({ float = { border = "single" } }) end,
            description = 'Diagnostics: Previous',
            opts = opts
        },
        {
            ']d',
            function() vim.diagnostic.goto_next({ float = { border = "single" } }) end,
            description = 'Diagnostics: Next',
            opts = opts
        },
        { '<space>q', vim.diagnostic.setloclist, description = 'Diagnostic: Show location list', opts = opts },
        { '<space>f', vim.lsp.buf.format(),      description = 'LSP: Format file',               opts = opts },
        {
            ']u',
            function() require('illuminate').next_reference({ wrap = true }) end,
            description = "Illuminate: Next reference",
            opts = opts
        },
        {
            '[u',
            function() require('illuminate').next_reference({ reverse = true, wrap = true }) end,
            description = "Illuminate: Previous reference",
            opts = opts
        }
    })

    -- if client.server_capabilities.document_formatting then
    --     vim.cmd([[
    --         augroup LspFormatting
    --             autocmd! * <buffer>
    --             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    --         augroup END
    --         ]])
    -- end
end

local notify = require('notify')
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
    notify({ result.message }, lvl, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == 'ERROR' or lvl == 'WARN'
        end,
    })
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
--local cmp_nvim_lsp = require('cmp_nvim_lsp')
require 'cmp'.setup {
    sources = {
        { name = 'nvim_lsp' }
    }
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Enable Language Server
local function default_lsp_setup(module)
    nvim_lsp[module].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Bash
default_lsp_setup('bashls')
-- Dart
default_lsp_setup('dartls')
nvim_lsp.vls.setup {
    cmd = { 'vue' },
    on_attach = on_attach,
    capabilities = capabilities
}

-- Elixir
nvim_lsp.elixirls.setup {
    cmd = { 'elixir-ls' },
    -- Settings block is required, as there is no default set for elixir
    settings = {
        elixirLs = {
            dialyzerEnabled = true,
            dialyzerFormat = "dialyxir_long"
        }
    },
    on_attach = on_attach,
    capabilities = capabilities
}
-- Erlang
default_lsp_setup('erlangls')
-- Haskell
default_lsp_setup('hls')
-- Java
nvim_lsp.java_language_server.setup {
    cmd = { 'java-language-server' },
    on_attach = on_attach,
    capabilities = capabilities
}
-- Kotlin
default_lsp_setup('kotlin_language_server')
-- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            completion = {
                callSnippet = 'Replace'
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            }
        }
    },
    on_attach = on_attach,
    capabilities = capabilities
}
-- Nix
nvim_lsp.rnix.setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Let statix format
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end
}
-- Python
-- default_lsp_setup('pylsp')
nvim_lsp.pylsp.setup {
on_attach = on_attach,
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
capabilities = capabilities,
}

-- Typescript
nvim_lsp.tsserver.setup {
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Let eslint format
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            enable_import_on_completion = true
        })
        ts_utils.setup_client(client)

        -- Mappings.
        local opts = { noremap = true, silent = true, buffer = true }
        require('legendary').keymaps({
            { 'gto', ':TSLspOrganize<CR>',   description = 'LSP: Organize imports',       opts = opts },
            { 'gtr', ':TSLspRenameFile<CR>', description = 'LSP: Rename file',            opts = opts },
            { 'gti', ':TSLspImportAll<CR>',  description = 'LSP: Import missing imports', opts = opts }
        })
    end,
    capabilities = capabilities
}
-- Web
-- ESLint
nvim_lsp.eslint.setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Run all eslint fixes on save
        vim.cmd([[
            augroup EslintOnSave
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> EslintFixAll
            augroup END
            ]])
    end,
    capabilities = capabilities
}
-- CSS
default_lsp_setup('cssls')
-- HTML
default_lsp_setup('html')
-- JSON
default_lsp_setup('jsonls')

-- RUST
nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- NULL
require("null-ls").setup({
    sources = {
        -- Elixir
        require("null-ls").builtins.diagnostics.credo,

        -- Nix
        require("null-ls").builtins.formatting.nixpkgs_fmt,
        require("null-ls").builtins.diagnostics.statix,
        require("null-ls").builtins.code_actions.statix
    },
})
