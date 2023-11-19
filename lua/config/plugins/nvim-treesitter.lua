return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
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
            }
        })
    end
}
