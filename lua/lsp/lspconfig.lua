--gopls正常工作的前提是提前设定好下面四条环境变量在bashrc或zshrc等
--export GOPATH=$HOME/go
--export GOROOT=/usr/lib/go
--export PATH=$PATH:$GOPATH
--export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
--clangd可以官网下载

-- Determine OS
--local home = os.getenv "HOME"
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local icons = require "conf.icons"
local signs = {

{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end


local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>Telescope diagnostics theme=dropdown<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    if client.name == "sumneko_lua"  then
        vim.notify('sumneko_lua at your service!')
    end

    if client.name == "pyright"  then
        vim.notify('pyright at your service!')
    end

    if client.name == "gopls"  then
        vim.notify('gopls at your service!')
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions theme=dropdown<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations theme=dropdown<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>Telescope lsp_type_definitions theme=dropdown<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>Telescope lsp_code_actions theme=cursor previewer=false<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'pyright', 'gopls' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end

--clangd_extensions with clangd
require("clangd_extensions").setup{
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
}

--sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

--local sumneko_root_path = '/usr/lib/lua-language-server/'
--local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"
require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
    };
    --cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path
            },
            diagnostics = {
                globals = {"vim"}
            },
            workspace = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
            },
            telemetry = {
                enable = false
            }
        }
    }
}
