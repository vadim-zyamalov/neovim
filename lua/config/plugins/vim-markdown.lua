return {
    "plasticboy/vim-markdown",
    ft = "markdown",
    init = function()
        vim.g.vim_markdown_folding_disabled = 1
        vim.g.vim_markdown_conceal = 0
        vim.g.vim_markdown_conceal_code_blocks = 0
    end
}

