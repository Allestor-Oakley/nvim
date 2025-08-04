-- Better neovim ui
return {
    -- Improve neovim ui
    {
        'stevearc/dressing.nvim',
        event = vim.g.open_file_evt,
        config = function()
            require('dressing').setup({
                input = {
                    relative = "editor",
                }
            })
        end
    },

    -- Better quickfix
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf'
    },

    -- Better notification
    {
        'rcarriga/nvim-notify',
        event = vim.g.open_file_evt,
        config = function()
            require("notify").setup({
                background_colour = "#000000",
                animate = false,
                stages = "static"
            })
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, ...)
                if
                    msg
                    and (
                        msg:match 'position_encoding param is required'
                        or msg:match 'Defaulting to position encoding of the first client'
                        or msg:match 'multiple different client offset_encodings'
                        or msg:match 'symbols_to_items must be called with valid position encoding'
                    )
                then
                    return
                end
                return require("notify")(msg, ...)
            end
        end
    },
}
