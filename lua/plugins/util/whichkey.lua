return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        delay = 800,
        spec = {
            { "<leader>\\", group = "DAP" },
            { "<leader>f",  group = "Telescope" },
            { "<leader>l",  group = "LSP and Lazy" },
            { "<leader>g",  group = "Git and GoTo" },
            {
                "<leader>t",
                group = "Test, Task, and Tab",
                icon = { icon = '', color = 'yellow' }
            },
            { "<leader>r", group = "Refactoring" },
            { "<leader>`", group = "Kulala" },
        },
        icons = {
            rules = {
                { pattern = "ufo", icon = "󱃅", color = "cyan" },
                { pattern = "dap", icon = '', color = 'red' },
                { pattern = "lsp", icon = '', color = 'cyan' },
                { pattern = "lazy", icon = '󰒲', color = 'red' },
                { plugin = "lazygit.nvim", icon = '', color = 'orange' },
                { pattern = "neotest", icon = '', color = 'yellow' },
                { pattern = "overseer", icon = '', color = 'yellow' },
                { pattern = "tab", icon = '󰓩', color = 'yellow' },
                { pattern = "kulala", icon = '', color = 'cyan' },
                { pattern = "fullscreen", icon = '', color = 'cyan' },
                { pattern = "spider", icon = '󱇪', color = 'green' },
                { pattern = "flash", icon = '', color = 'yellow' },
                { pattern = "split", icon = '󰝘', color = 'red' },
                { pattern = "whichkey", icon = '', color = 'red' },
                { pattern = "scroll", icon = '󱕐', color = 'blue' },
                { pattern = "ts node action", icon = '', color = 'yellow' },
                { pattern = "minty", icon = '', color = 'cyan' },
                { pattern = "neotree", icon = '', color = 'orange' },
                { pattern = "yazi", icon = '', color = 'orange' },
                { pattern = "menu", icon = '󱕐', color = 'blue' },
                { pattern = "treewalker", icon = '', color = 'green' },
            }
        }
    },
    keys = {
        {
            "<F4>",
            function()
                require("which-key").show({ global = true })
            end,
            desc = "Whichkey: Show All Keymap",
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
    end,
}
