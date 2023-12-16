return {
  -- Выравнивание текста по разделителю
  {
    "echasnovski/mini.align",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local pkg = require("mini.align")
      pkg.setup()
    end,
  },

  -- Комментирование кусков текста
  -- {
  --   "numToStr/Comment.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "JoosepAlviste/nvim-ts-context-commentstring",
  --   },
  --   config = function()
  --     local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
  --
  --     require("Comment").setup {
  --       pre_hook = ts_context_commentstring.create_pre_hook(),
  --     }
  --   end,
  -- },
  {
    "echasnovski/mini.comment",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local pkg = require("mini.comment")
      pkg.setup()
    end,
  },

  -- Определяем отступы (индентацию, прошу прощения)
  {
    "Darazaki/indent-o-matic",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("indent-o-matic").setup {}
    end,
  },

  -- определив - показываем
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },

  -- Расстановка и изменение окружений (скобок, тегов...)
  -- {
  --   "kylechui/nvim-surround",
  --   event = { "BufReadPre", "BufNewFile" },
  --   version = "*",
  --   config = true,
  -- },
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local pkg = require("mini.surround")
      pkg.setup()
    end,
  },

  -- Расстановка парных скобок
  -- {
  --   "windwp/nvim-autopairs",
  --   event = { "InsertEnter" },
  --   opts = {
  --     map_cr = true,
  --   },
  -- },
  {
    "echasnovski/mini.pairs",
    version = false,
    event = { "InsertEnter" },
    config = function()
      local pkg = require("mini.pairs")
      pkg.setup()
    end,
  },
}
