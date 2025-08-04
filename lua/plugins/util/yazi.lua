return {
    "mikavilpas/yazi.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    cmd = { "Yazi" },
    keys = {
        {
            "<leader>E",
            "<cmd>Yazi cwd<cr>",
            desc = "Yazi: Open",
        },
    },
    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
        },
        floating_window_scaling_factor = vim.g.flsize
    },
}
