return {
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
}
