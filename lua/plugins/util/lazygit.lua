return {
    "kdheepak/lazygit.nvim",
    init = function()
        vim.api.nvim_set_hl(0, "LazyGitBorder", { link = "FloatBorder" })
        vim.g.lazygit_floating_window_scaling_factor = vim.g.flsize + 0.001
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
