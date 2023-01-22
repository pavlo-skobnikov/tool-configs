local utility_fns = require("utility.functions")
local lsp_maps = require("user.lsp_maps")

local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    vim.fn.expand('-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar',
    vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"),
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration', vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/config_mac/"),
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', vim.fn.expand("$HOME/.cache/jdtls/workspace/") .. project_name,
  },

  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()

    lsp_maps.on_startup() -- Add common LSP mappings

    lsp_maps.on_attach(client, bufnr)

    -- LSP mappings specific to nvim-jdtls
    local map_w_opts = utility_fns.create_mapping_fn_with_default_opts_and_desc(
      { noremap = true, silent = true })

    map_w_opts("n", "<space>ri", jdtls.organize_imports, "Organize Imports")
    map_w_opts("n", "<space>rv", jdtls.extract_variable, "Extract Variable")
    map_w_opts("v", "<space>rv", function() jdtls.extract_variable(true) end, "Extract Variable")
    map_w_opts("n", "<space>rc", jdtls.extract_constant, "Extract Constant")
    map_w_opts("v", "<space>rc", function() jdtls.extract_constant(true) end, "Extract Constant")
    map_w_opts("n", "<space>rm", jdtls.extract_method, "Extract Method")
    map_w_opts("v", "<space>rm", function() jdtls.extract_constant(true) end, "Extract Method")

    -- This requires java-debug and vscode-java-test bundles
    -- nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
    -- nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
  end,

  -- 💀
  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
