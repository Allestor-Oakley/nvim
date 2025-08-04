local keymap = require("plugins.components.gen_keymap")("Gitsigns")
return {
    'lewis6991/gitsigns.nvim',
    event = vim.g.open_file_evt,
    keys = {
        keymap("<leader>gp", ":Gitsigns preview_hunk<cr>", "[P]review Hunk"),
        keymap("<leader>gb", ":Gitsigns blame_line<cr>", "[B]lame Line"),
        keymap("<leader>gs", ":Gitsigns stage_hunk<cr>", "[S]tage Hunk"),
        keymap("<leader>gu", ":Gitsigns reset_hunk<cr>", "[U]ndo Hunk"),
        keymap("<leader>g,", ":Gitsigns prev_hunk<cr>", "Prev Hunk"),
        keymap("<leader>g.", ":Gitsigns next_hunk<cr>", "Next Hunk"),
    },
    config = true,
}
