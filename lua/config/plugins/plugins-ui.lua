return {
  -- Цветовая схема Catppuccin
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

  -- Информационная строка
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

  -- Строка вкладок с буферами
  {
    "echasnovski/mini.tabline",
    version = false,
    config = function()
      require("mini.tabline").setup()
    end,
  },

  -- Вспплывающие окна, заменяющие ввод текста в командной строке
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Подсказки сочетаний клавиш
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },

  -- Раскрашивание цветов в тексте
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

  -- Стартовый экран
  {
    "echasnovski/mini.starter",
    version = false,
    config = function()
      local pkg = require("mini.starter")
      pkg.setup()
    end,
  },
}
