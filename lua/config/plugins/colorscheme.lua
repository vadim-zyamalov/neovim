return {
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
}
