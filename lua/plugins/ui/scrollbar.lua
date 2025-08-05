return {
    'petertriho/nvim-scrollbar',
    event = vim.g.open_file_evt,
    opts = {
        show_in_active_only = true,
        excluded_filetypes = {
            "alpha",
            "prompt",
            "TelescopePrompt",
            "blink-cmp-menu",
            "cmp_docs",
            "cmp_menu",
            "DressingInput"
        }
    }
}
