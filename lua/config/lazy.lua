-- Lazy.nvim bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
}

require("lazy").setup(
    {
        "dstein64/nvim-scrollview",
        {
            "mg979/vim-visual-multi",
            event = { "BufReadPre", "BufNewFile" },
        },
        { import = "config.plugins" }
    },
    opts
)
