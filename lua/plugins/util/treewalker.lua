return {
    'aaronik/treewalker.nvim',
    event = vim.g.open_file_evt,
    opts = {},
    config = function(_, opts)
        local dp = "Treewalker: "
        -- swapping
        vim.keymap.set('n', '<C-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true, desc = dp .. "Swap Up" })
        vim.keymap.set('n', '<C-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true, desc = dp .. "Swap Down" })
        vim.keymap.set('n', '<C-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true, desc = dp .. "Swap Right" })
        vim.keymap.set('n', '<C-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true, desc = dp .. "Swap Left" })
        require("treewalker").setup(opts)
    end
}
