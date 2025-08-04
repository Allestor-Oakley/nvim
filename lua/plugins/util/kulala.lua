return {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
        { "<leader>`b", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Kulala: Open scratchpad", ft = "http" },
        { "<leader>`c", "<cmd>lua require('kulala').copy()<cr>",       desc = "Kulala: Copy as cURL",    ft = "http" },
        {
            "<leader>`g",
            "<cmd>lua require('kulala').download_graphql_schema()<cr>",
            desc = "Kulala: Download GraphQL schema",
            ft = "http",
        },
        { "<leader>`i", "<cmd>lua require('kulala').inspect()<cr>",   desc = "Kulala: Inspect current request",  ft = "http" },
        { "<leader>`,", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Kulala: Jump to previous request", ft = "http" },
        { "<leader>`.", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Kulala: Jump to next request",     ft = "http" },
        { "<leader>`r", "<cmd>lua require('kulala').replay()<cr>",    desc = "Kulala: Replay the last request",  ft = "http" },
        { "<leader>`s", "<cmd>lua require('kulala').run()<cr>",       desc = "Kulala: Send the request",         ft = "http" },
    },
    opts = {},
}
