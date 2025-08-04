return {
    -- Auto tag and pair
    {
        "windwp/nvim-ts-autotag",
        opts = {},
        event = vim.g.open_file_evt,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
}
