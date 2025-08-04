return {
    "kdheepak/lazygit.nvim",
    init = function()
        vim.g.lazygit_floating_window_scaling_factor = vim.g.flsize
    end,
    cmd = "LazyGit",
    keys = {
        {
            "<leader>gg",
            ":LazyGit<CR>",
            desc = "Lazygit: Open",
            noremap = true,
            silent = true
        }
    }
}
