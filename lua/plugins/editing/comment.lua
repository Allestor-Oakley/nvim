return {
    -- Comment
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
        end,
        event = vim.g.open_file_evt
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = vim.g.open_file_evt
    },

}
