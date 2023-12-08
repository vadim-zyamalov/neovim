return {
  "Darazaki/indent-o-matic",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("indent-o-matic").setup {}
  end,
}
