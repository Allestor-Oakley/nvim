return {
    -- Indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
        event = vim.g.open_file_evt
    },
    {
        'Darazaki/indent-o-matic',
        event = vim.g.open_file_evt,
        opts = {}
    },
}
