return {
  -- nvim-lspconfig - встроенный набор настроек для работы LSP с разными языками.
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   "hrsh7th/cmp-nvim-lsp",
    -- },
    config = function()
      local servers = { "pyright", "lua_ls", "texlab" }

      local nvim_lsp = require("lspconfig")
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        buffer = 0,
        command = "lua vim.lsp.buf.document_highlight()",
      })
      vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
        buffer = 0,
        command = "lua vim.lsp.buf.document_highlight()",
      })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        buffer = 0,
        command = "lua vim.lsp.buf.clear_references()",
      })

      local my_custom_on_attach = function(_)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "c-]", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
      end

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
          -- capabilities = capabilities,
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
}
