return {
    -- Treesitter node action
    {
        'ckolkey/ts-node-action',
        keys = {
            { "K", desc = "TS Node Action: Action" }
        },
        dependencies = { "nvim-treesitter" },
        config = function()
            require("ts-node-action").setup({})
            vim.keymap.set({ "n" }, "K", require("ts-node-action").node_action, { desc = "TS Node Action: Action" })
        end
    },
}
