return {
  { -- Completion engine
    "hrsh7th/nvim-cmp",
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
          ["<C-y>"] = cmp.mapping(cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }, { "i", "c" }),
          ["<C-S-y>"] = cmp.mapping(cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }, { "i", "c" }),

          ["<C-space>"] = cmp.mapping {
            ---@diagnostic disable: missing-parameter
            i = cmp.mapping.complete(),
            c = function( _ --[[fallback]])
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

        experimental = {
          -- Cool text preview in the editor
          ghost_text = true,
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
  { "hrsh7th/cmp-buffer" }, -- Current buffer completions
  { "hrsh7th/cmp-path" }, -- Directory/file path completions
  { "hrsh7th/cmp-nvim-lua" }, -- Special NeoVim-aware Lua completions
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP-integration completions
  { "onsails/lspkind-nvim" }, -- VSCode-style completion kinds
  { "tamago324/cmp-zsh" }, -- Zsh completions Zsp
  { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } }, -- Snippet engine
  { "rafamadriz/friendly-snippets" } -- A bunch of snippets to use
}
