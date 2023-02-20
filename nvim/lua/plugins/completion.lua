-- Description: Everything related to completion i.e. completion engine, sources, snippets, etc.
return {
  { -- Completion engine
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "tamago324/cmp-zsh",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "github/copilot.vim",
      "nvim-orgmode/orgmode",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip/loaders/from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { "i", "c" }
          ),
          ["<M-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            },
            { "i", "c" }
          ),

          ["<C-space>"] = cmp.mapping {
            ---@diagnostic disable: missing-parameter
            i = cmp.mapping.complete(),
            c = function(_ --[[fallback]])
              if cmp.visible() then
                if not cmp.confirm { select = true } then
                  return
                end
              else
                cmp.complete()
              end
            end,
          },
        },
        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              luasnip = "[snip]",
            },
          },
        },

        -- Order for completion suggestions
        sources = {
          { name = "nvim_lua" },
          { name = 'orgmode' },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
        },

        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },

        window = {
          -- Nice round borders for completion windows
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

      }

      -- Use buffer source for searches `/` and `?`.
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-y>"] = {
            c = cmp.mapping.confirm({ select = false }),
          }
        }),
        sources = cmp.config.sources({
          { name = 'cmdline' }
        }, {
          { name = 'buffer' },
          { name = "path" },
        })
      })
    end,
  },
  { -- Current buffer completions
    'hrsh7th/cmp-buffer',
  },
  { -- Directory/file path completions
    'hrsh7th/cmp-path',
  },
  { -- Special NeoVim-aware Lua completions
    'hrsh7th/cmp-nvim-lua',
  },
  { -- LSP-integration completions
    'hrsh7th/cmp-nvim-lsp',
  },
  { -- VSCode-style completion kinds
    'onsails/lspkind-nvim',
  },
  { -- Zsh completions Zsp
    'tamago324/cmp-zsh',
  },
  { -- Snippet engine
    'saadparwaiz1/cmp_luasnip',
    dependencies = { "L3MON4D3/LuaSnip" },
  },
  { -- A bunch of snippets to use
    'rafamadriz/friendly-snippets',
  },
  { -- AI-powered code completion
    'github/copilot.vim',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Bring up the suggestions panel
      vim.keymap.set("n", "<C-;>", ":Copilot panel<CR>", { noremap = true, silent = true })
      vim.keymap.set("i", "<C-;>", "<ESC>:Copilot panel<CR>", { noremap = true, silent = true })
    end,
  }
}

