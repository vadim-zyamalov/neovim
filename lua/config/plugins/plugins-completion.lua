return {
  -- nvim-cmp и его зависимости
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-omni",
      "dcampos/nvim-snippy",
      "dcampos/cmp-snippy",
      "onsails/lspkind.nvim",
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- nvim-cmp
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      local snippy = require("snippy")

      cmp.setup {
        completion = {
          autocomplete = false,
        },
        formatting = {
          format = lspkind.cmp_format {
            maxwidth = 50,
          },
        },
        snippet = {
          expand = function(args)
            snippy.expand_snippet(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.close(),
            c = cmp.mapping.close(),
          },
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snippy.can_jump(-1) then
              snippy.previous()
            else
              fallback()
            end
          end,
        },
        sources = {
          {
            name = "path",
            option = {
              get_cwd = function(_)
                return vim.loop.cwd()
              end,
            },
          },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "snippy" },
        },
      }

      -- Snippy
      snippy.setup {}
    end,
  },

  -- {
  --   "echasnovski/mini.completion",
  --   version = false,
  --   config = function()
  --     local pkg = require("mini.completion")
  --     pkg.setup {
  --       window = {
  --         info = { border = "double" },
  --         signature = { border = "double" },
  --       },
  --     }
  --   end,
  -- },
}
