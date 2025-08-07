return {
    -- Auto tag and pair
    {
        "windwp/nvim-ts-autotag",
        opts = {},
        event = vim.g.open_file_evt,
    },
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        branch = 'v0.6',
        opts = {},
    }
}
