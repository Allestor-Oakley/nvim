return {
    'petertriho/nvim-scrollbar',
    event = vim.g.open_file_evt,
    opts = {
        show_in_active_only = true,
        excluded_filetypes = {
            "alpha", "TelescopePrompt"
        }
    }
}
