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
        config = function()
            vim.keymap.set({ "n", "o", "x" }, "f", "<Plug>(clever-f-f)", { desc = "Clever: f" })
            vim.keymap.set({ "n", "o", "x" }, "F", "<Plug>(clever-f-F)", { desc = "Clever: F" })
            vim.keymap.set({ "n", "o", "x" }, "t", "<Plug>(clever-f-t)", { desc = "Clever: t" })
            vim.keymap.set({ "n", "o", "x" }, "T", "<Plug>(clever-f-T)", { desc = "Clever: T" })
        end,
        event = vim.g.open_file_evt,
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
