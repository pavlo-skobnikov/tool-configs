return {
  { "folke/neodev.nvim" }, -- NeoVim-specific Lua LSP extension
  { "mfussenegger/nvim-jdtls" }, -- Java LSP but better
  { "williamboman/mason.nvim" }, -- Easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface
  { "williamboman/mason-lspconfig.nvim" }, -- Bridges mason.nvim with the lspconfig plugin -> making it easier to use both plugins together
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "sumneko_lua", "jdtls", "gradle_ls", "dockerls", "marksman", "yamlls", "jsonls" },
        automatic_installation = false,
      })
      require("neodev").setup()

      local lsp_maps = require("user.lsp_maps")

      lsp_maps.on_startup()

      local lsp_config = require("lspconfig")

      lsp_config.sumneko_lua.setup({
        on_attach = lsp_maps.on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
              }
            }
          }
        }
      })

      lsp_config.gradle_ls.setup({
        on_attach = lsp_maps.on_attach
      })
      lsp_config.dockerls.setup({
        on_attach = lsp_maps.on_attach
      })
      lsp_config.marksman.setup({
        on_attach = lsp_maps.on_attach
      })
      lsp_config.yamlls.setup({
        on_attach = lsp_maps.on_attach
      })
      lsp_config.jsonls.setup({
        on_attach = lsp_maps.on_attach
      })
    end
  },
}
