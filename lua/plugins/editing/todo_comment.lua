return {
    "folke/todo-comments.nvim",
    event = vim.g.open_file_evt,
    opts = {},
    ---@format disable-next
    keys = {
        { "<leader>t0", "<cmd>Trouble todo toggle<cr>", desc = "Todo: [O]pen" },
        { "<leader>fo", "<cmd>TodoTelescope<cr>", desc = "Telescope: T[o]do" },
    },
}
