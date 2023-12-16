return {
  -- Перемещение по файлу
  -- {
  --   "unblevable/quick-scope",
  --   event = { "BufReadPre", "BufNewFile" },
  --   init = function()
  --     vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
  --     vim.g.qs_lazy_highlight = 1
  --   end,
  -- },
  {
    "echasnovski/mini.jump",
    version = false,
    config = function()
      local pkg = require("mini.jump")
      pkg.setup()
    end,
  },

  -- Перемещение при помощи квадратных скобок
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      local pkg = require("mini.bracketed")
      pkg.setup()
    end,
  },

  -- Перемещение по буферам, файлам, справке, поиск всякого
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true })
    end,
  },

  -- Перемещение по фаловой системе, опрерирование с файлами
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}
