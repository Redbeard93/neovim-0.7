local status, jdtls = pcall(require, "jdtls")
if not status then
    vim.notify("jdtls is down!!!")
    return
end

local env = {
    -- HOME = vim.loop.os_homedir(),
    MAVEN_SETTINGS = os.getenv 'MAVEN_SETTINGS',
}

local maven_settings = '/opt/software/apache-maven-3.8.4/conf/settings.xml'

local function get_maven_settings()
    return env.MAVEN_SETTINGS and env.MAVEN_SETTINGS or maven_settings
end

-- Determine OS
local home = os.getenv "HOME"
if vim.fn.has "mac" == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
    WORKSPACE_PATH = home .. "/.config/nvim/workspace/folder/"
    CONFIG = "linux"
else
    print "Unsupported system"
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name
local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(home .. "/.config/nvim/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        home .. "/.config/nvim/jdtls/config_" .. CONFIG,
        "-data",
        workspace_dir,
    },
    on_attach = java_on_attach,
    capabilities = capabilities,
    root_dir = root_dir,
    settings = {
        java = {

            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                -- settings = {
                --   profile = "asdf"
                -- }
            },
        }
    },

    signatureHelp = { enabled = true },
    completion = {
        favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
        },
    },
    extendedClientCapabilities = extendedClientCapabilities,
    contentProvider = { preferred = "fernflower" },
    sources = {
        organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
        },
    },
    codeGeneration = {
        toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
    },
    flags = {
        allow_incremental_sync = true,
    },
    configuration = {
        maven={
            userSettings = get_maven_settings(),
            globalSettings = get_maven_settings(),

        },
        runtimes = {
        {
                name = "JavaSE-11",
                path = "/usr/lib/jvm/java-11-openjdk/",
            },
        {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk/",
            },
        }
    };
    init_options = {
        bundles = {bundles}
    }
}

local bundles = {
    vim.fn.glob(home .. "/.config/nvim/debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")

};

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/debug/vscode-java-test/server/*.jar"),"\n"))

local current_buff = vim.api.nvim_get_current_buf
-- 在语言服务器附加到当前缓冲区之后
-- 使用 on_attach 函数仅映射以下键
local java_on_attach = function(client, bufnr)

    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.setup').add_commands()
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = {noremap = true, silent = true}
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    --重命名
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --智能提醒，比如：自动导包 已经用lspsaga里的功能替换了
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    --代码格式化
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --自动导入全部缺失的包，自动删除多余的未用到的包
    buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    --引入局部变量的函数 function to introduce a local variable
    buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    --function to extract a constant
    buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    --将一段代码提取成一个额外的函数function to extract a block of code into a method
    buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- 代码保存自动格式化formatting
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]

    vim.cmd([[

    function! s:jdtls_test_class_ui()
    lua require'jdtls'.test_class()
    lua require'dapui'.open()
    endfunction

    function! s:jdtls_test_method_ui()
    lua require'jdtls'.test_nearest_method()
    lua require'dapui'.open()
    endfunction

    nnoremap <leader>dc <Cmd>lua require'jdtls'.test_class()<CR>

    nnoremap <leader>dm <Cmd>lua require'jdtls'.test_nearest_method()<CR>

    nnoremap <leader>dr <Cmd>JdtRefreshDebugConfigs<CR>

    command! -nargs=0 TestClass  :lua require'jdtls'.test_class()
    command! -nargs=0 TestMethod  :lua require'jdtls'.test_nearest_method()
    command! -nargs=0 TestClassUI  :call s:jdtls_test_class_ui()
    command! -nargs=0 TestMethodUI :call s:jdtls_test_method_ui()
   " command! -nargs=0 JdtRefreshDebugConfigs :lua require('jdtls.dap').setup_dap_main_class_configs()
    command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
    command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
    command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
    command! -buffer JdtJol lua require('jdtls').jol()
    command! -buffer JdtBytecode lua require('jdtls').javap()
    command! -buffer JdtJshell lua require('jdtls').jshell()
]])
end

java_on_attach(nil, current_buff)

require("jdtls").start_or_attach(config)

require('keymaps')
