return {
  -- Перемещение по файлу
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
}
