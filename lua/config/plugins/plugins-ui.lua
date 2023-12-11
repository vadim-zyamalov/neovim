return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        integrations = {
          cmp = true,
          treesitter = true,
          mason = false,
          nvimtree = true,
          telescope = {
            enabled = true,
          },
        },
      }
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lazy_status = require("lazy.status")

      require("lualine").setup {
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      }
    end,
  },
  {
    "echasnovski/mini.tabline",
    version = false,
    config = function()
      require("mini.tabline").setup()
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },
  {
    "rrethy/vim-hexokinase",
    run = "make hexokinase",
    event = { "BufReadPre", "BufNewFile" },
    cond = (vim.fn.has("unix") == 1),
    config = function()
      vim.g.Hexokinase_highlighters = { "backgroundfull" }
      vim.g.Hexokinase_refreshEvents = { "InsertLeave" }
      vim.g.Hexokinase_optInPatterns = {
        "full_hex",
        "triple_hex",
        "rgb",
        "rgba",
        "hsl",
        "hsla",
        "colour_names",
      }
      vim.api.nvim_create_autocmd({ "VimEnter" }, { command = "HexokinaseTurnOn" })
    end,
  },

  {
    "echasnovski/mini.starter",
    version = false,
    config = function()
      local pkg = require("mini.starter")
      pkg.setup()
    end,
  },
}
