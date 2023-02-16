-- Description: Everything related to Language Server Protocol
return {
  { -- LSP extension for NeoVim-specific Lua development
    "folke/neodev.nvim",
    dependencies = {
      "nvim-neotest/neotest"
    },
  },
  { -- Improvements for the Eclipse JDT Language Server
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "SmiteshP/nvim-navic",
    },
  },
  { -- Easily manage external editor tooling such as LSP servers,
    -- DAP servers, linters, and formatters through a single interface
    "williamboman/mason.nvim",
  },
  { -- Bridges mason.nvim with the lspconfig plugin
    -- -> making it easier to use both plugins together
    "williamboman/mason-lspconfig.nvim",
  },
  { -- Native LSP configuration for NeoVim
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "sumneko_lua",
          "jdtls",
          "gradle_ls",
          "dockerls",
          "marksman",
          "yamlls",
          "jsonls",
          "quick_lint_js"
        },

        automatic_installation = false,
      })

      require("neodev").setup({
        library = { plugins = { "neotest" }, types = true }
      })

      local navic = require("nvim-navic")

      local lsp_maps = require("shared.lsp_maps")

      lsp_maps.on_startup()

      local lsp_config = require("lspconfig")

      local on_attach = function(client, bufnr)
        lsp_maps.on_attach(client, bufnr)

        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      lsp_config.sumneko_lua.setup({
        on_attach = on_attach,

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

      lsp_config.gradle_ls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.dockerls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.marksman.setup { on_attach = lsp_maps.on_attach }
      lsp_config.yamlls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.jsonls.setup { on_attach = lsp_maps.on_attach }
    end
  },
  { -- Debug Adapter Protocol client implementation
    "mfussenegger/nvim-dap",
  },
  { -- A UI for nvim-dap
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
  },
}

