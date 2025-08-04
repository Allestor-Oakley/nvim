return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        open_no_results = true,
        modes = {
            diagnostics = {
                win = {
                    size = vim.g.hspsize,
                },
            }
        }
    },
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    keys = {
        { "<leader>lo", "<cmd>Trouble diagnostics toggle<cr>", desc = "LSP: Trouble Diagnostics" }
    }
}
