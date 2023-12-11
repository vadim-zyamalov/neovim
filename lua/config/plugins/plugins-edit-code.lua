return {
  -- nvim-lspconfig - встроенный набор настроек для работы LSP с разными языками.
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local nvim_lsp = require("lspconfig")

      vim.api.nvim_create_autocmd({ "CursorHold" }, { buffer = 0, command = "lua vim.lsp.buf.document_highlight()" })
      vim.api.nvim_create_autocmd({ "CursorHoldI" }, { buffer = 0, command = "lua vim.lsp.buf.document_highlight()" })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, { buffer = 0, command = "lua vim.lsp.buf.clear_references()" })

      local my_custom_on_attach = function(_)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "c-]", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "pyright", "lua_ls", "texlab" }
      for _, lsp in ipairs(servers) do
        local settings = {}
        if lsp == "lua_ls" then
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          }
        end
        nvim_lsp[lsp].setup {
          on_attach = my_custom_on_attach,
          capabilities = capabilities,
          settings = settings,
        }
      end
    end,
  },

  -- Mason для автоматической установки LSP-серверов, линтеров и пр.
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },

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
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "snippy" },
        },
      }

      -- Snippy
      snippy.setup {}
    end,
  },

  -- Treesitter. Сложно сказать, куда его включать...
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "python", "latex" },
        sync_install = false,
        highlight = {
          enable = true,
          disable = { "python" },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "python" },
        },
      }
    end,
  },

  -- Поиск ошибок в коде
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "flake8" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },

  -- Автоформатирование кода
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      local conform = require("conform")

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      }

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
