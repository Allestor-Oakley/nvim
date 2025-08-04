return {
    'j-hui/fidget.nvim',
    event = vim.g.open_file_evt,
    opts = {
        notification = {
            window = {
                winblend = 0,
            }
        },
        progress = {
            ignore = { "null-ls" },
            display = {
                progress_icon = {
                    pattern = "bouncing_ball",
                }
            }
        }
    }
}
