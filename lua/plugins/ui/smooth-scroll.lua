return {
    "karb94/neoscroll.nvim",
    event = vim.g.open_file_evt,
    opts = {
        mappings = {}
    },
    config = function(_, opts)
        local neoscroll = require('neoscroll')
        vim.keymap.set("n", "<A-p>", function()
            neoscroll.ctrl_u({ duration = 100 })
        end, { desc = "Smooth Scroll: Up" })
        vim.keymap.set("n", "<A-;>", function()
            neoscroll.ctrl_d({ duration = 100 })
        end, { desc = "Smooth Scroll: Down" })
        neoscroll.setup(opts)
    end
}
