return {
    -- Movement
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = vim.g.open_file_evt,
        config = true,
    },
    {
        "rhysd/clever-f.vim",
        event = vim.g.open_file_evt,
    },
    {
        "chrisgrieser/nvim-spider",
        config = function()
            require("spider").setup({})
            vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
            vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
            vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
            vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
        end,
        event = vim.g.open_file_evt
    },
    {
        "folke/flash.nvim",
        opts = {
            highlight = {
                backdrop = false,
            },
            modes = {
                char = {
                    enabled = false
                }
            }
        },
        ---@format disable-next
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: Flash" },
            { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash: Treesitter" },
            { "<A-s>", mode = { "x" }, function() require("flash").treesitter() end, desc = "Flash: Visual Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Flash: Remote" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Flash: Toggle Search" },
        },
    }
}
