return {
    "olimorris/onedarkpro.nvim",
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0,
    priority = 1000, -- Ensure it loads first
    config = function()
        require("onedarkpro").setup({
            options = {
                transparency = true,
            },
            highlights = {
                ["@include.python"] = { link = "Keyword" }
            }
        })

        vim.cmd("colorscheme onedark_vivid")
    end,
}
