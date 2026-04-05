return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        delay = 800,
        spec = {
            { "<leader>f", group = "Telescope" },
            { "<leader>l", group = "LSP and Lazy" },
            { "<leader>g", group = "Git and GoTo" },
            {
                "<leader>t",
                group = "Task and Tab",
                icon = { icon = '', color = 'yellow' }
            },
            { "<leader>b", group = "Bufferline" },
        },
        icons = {
            rules = {
                { pattern = "ufo", icon = "󱃅", color = "cyan" },
                { pattern = "lsp", icon = '', color = 'cyan' },
                { pattern = "lazy", icon = '󰒲', color = 'red' },
                { plugin = "lazygit.nvim", icon = '', color = 'orange' },
                { pattern = "overseer", icon = '', color = 'yellow' },
                { pattern = "tab", icon = '󰓩', color = 'yellow' },
                { pattern = "fullscreen", icon = '', color = 'cyan' },
                { pattern = "flash", icon = '', color = 'yellow' },
                { pattern = "split", icon = '󰝘', color = 'red' },
                { pattern = "whichkey", icon = '', color = 'red' },
                { pattern = "scroll", icon = '󱕐', color = 'blue' },
                { pattern = "ts node action", icon = '', color = 'yellow' },
                { pattern = "neotree", icon = '', color = 'orange' },
                { pattern = "bufferline", icon = '󰓩', color = 'cyan' },
                { pattern = "clever", icon = '', color = 'cyan' },
                { pattern = "toggleterm", icon = '', color = 'yellow' },
            }
        },
        plugins = {
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
            }
        },
        sort = { "order", "group", "alphanum", "mod" },
    },
    keys = {
        {
            "<F4>",
            function()
                require("which-key").show({ global = true })
            end,
            desc = "Whichkey: Show Keymaps",
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
    end,
}
