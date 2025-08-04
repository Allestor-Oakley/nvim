return {
    'akinsho/bufferline.nvim',
    event = vim.g.open_file_evt,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#808080" })
        local bufferline = require('bufferline')
        vim.opt.showtabline = 2
        bufferline.setup({
            options = {
                numbers = function(opts)
                    return string.format('%s', opts.raise(opts.ordinal))
                end,
                show_buffer_close_icons = false,
                style_preset = {
                    bufferline.style_preset.no_italic
                },
                separator_style = "thin",
                indicator = {
                    style = 'underline'
                },
            },
        })

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>",
                { desc = "which_key_ignore", noremap = true, silent = true })
        end
        vim.keymap.set("n", "<leader>/", ":BufferLinePickClose<cr>",
            { desc = "Bufferline: Pick Close", noremap = true, silent = true })
    end,
}
