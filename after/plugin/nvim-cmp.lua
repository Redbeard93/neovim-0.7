local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then
    return
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- luasnip setup
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

-- nvim-cmp setup
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end
    },
    sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
    {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    {name = "path"},
    {name = "cmdline"},
    {name = "cmp_tabnine"}
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    view = {
      entries = 'native'
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
}

---- 命令行 / 模式提示
--cmp.setup.cmdline(
--    "/",
--{
--        sources = {
--        {name = "buffer"}
--        }
--    }
--)
---- 命令行 : 模式提示
--cmp.setup.cmdline(
--    ":",
--{
--        sources = cmp.config.sources(
--        {
--            {name = "path"}
--            },
--        {
--            {name = "cmdline"}
--            }
--        )
--    }
--)
