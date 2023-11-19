return {
    "nvim-lualine/lualine.nvim",
    config = function()
        lazy_status = require("lazy.status")

        require("lualine").setup({
            options = {
                theme = "onedark"
            },
            sections = {
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                }
            }
        })
    end
}

