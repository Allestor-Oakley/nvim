return {
    'kosayoda/nvim-lightbulb',
    event = vim.g.open_file_evt,
    opts = {
        autocmd = { enabled = true },
        sign = {
            enabled = false,
        },
        status_text = {
            enabled = true,
            text = "!",
            text_unavailable = " "
        },
    }
}
