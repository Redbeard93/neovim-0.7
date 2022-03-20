---@diagnostic disable: undefined-global
--在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system(
    {"git", "clone", "--depth", "1", "https://gitcode.net/mirrors/wbthomason/packer.nvim", install_path}
  ) --csdn加速镜像
    vim.cmd [[packadd packer.nvim]]
end
-- Only required if you have packer configured as `opt`
--【国内加速】插件名称超长的说明：
--由于国内网络环境访问github及其不稳定，所以如果在gitcode.net上的镜像的（https://gitcode.net/mirrors/开头的），我们尽量使用。这样可以提高访问速度。
--gitcode.net没有镜像的部分(https://gitcode.net/lxyoucan开头的),是我手动clone到gitcode上的不定期更新。
--如果你访问github比较流畅，插件名称只保留后两段即如：neovim/nvim-lspconfig

local status_ok, packer = pcall(require,"packer")
if not status_ok then
    vim.notify("packer`s down!!!")
    return
end
-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
return require("packer").startup(function()
    -- Packer可以管理自己的更新
    use "https://gitcode.net/mirrors/wbthomason/packer.nvim"
    --Nvim LSP 客户端的快速入门配置
    use "https://gitcode.net/mirrors/neovim/nvim-lspconfig"
    --自动提示插件
    use {
        "https://gitcode.net/mirrors/hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", --neovim 内置 LSP 客户端的 nvim-cmp 源
            "hrsh7th/cmp-buffer", --从buffer中智能提示
            "hrsh7th/cmp-path", --自动提示硬盘上的文件
            "hrsh7th/cmp-cmdline"
        }
    }

    use {
        "tzachar/cmp-tabnine",-- tabnine 源,提供基于 AI 的智能补全
        config = function()
            local tabnine = require "cmp_tabnine.config"
            tabnine:setup {
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = "..",
                ignored_file_types = { -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
            }
        end,

        run = "./install.sh",
        requires = "hrsh7th/nvim-cmp",
    }
    -- 代码调试基础插件
    use { "mfussenegger/nvim-dap", }

    -- 为代码调试提供内联文本
    use {
        "theHamsta/nvim-dap-virtual-text",
        requires = {
            "mfussenegger/nvim-dap"
        },
    }

    -- 为代码调试提供 UI 界面
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap"
        },
    }
    -- java语言支持
    use "mfussenegger/nvim-jdtls"
    -- 代码段提示
    use {
        "https://gitcode.net/mirrors/L3MON4D3/LuaSnip",
        requires = {
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "rafamadriz/friendly-snippets" --代码段合集
        }
    }

    -- 语法高亮
    use {
        "nvim-treesitter/nvim-treesitter",
        run = {":TSUpdate"},
        requires = {
            "p00f/nvim-ts-rainbow" -- 彩虹括号
        },
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
    }
    -- 精美弹窗
    use { "rcarriga/nvim-notify", }

    -- 搜索时显示条目
    use { "kevinhwang91/nvim-hlslens", }
    -- 自动会话管理
    use { "rmagatti/auto-session", }
    -- 显示网页色
    use { "norcalli/nvim-colorizer.lua", }
    -- 模糊查找
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim", -- Lua 开发模块
            "BurntSushi/ripgrep", -- 文字查找
            "sharkdp/fd" -- 文件查找
        },
    }
    -- Telescope 和 nvim-jdtls 互动的UI
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use "p00f/clangd_extensions.nvim"
end)

