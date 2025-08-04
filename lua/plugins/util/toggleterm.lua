return {
    'akinsho/toggleterm.nvim',
    event = vim.g.open_file_evt,
    config = function()
        require('toggleterm').setup({
            size = vim.g.hspsize,
            close_on_exit = false,
        })

        local keymap = function(keys, action, desc)
            vim.keymap.set("n", keys, action, {
                noremap = true,
                silent = true,
                desc = "ToggleTerm: " .. desc
            })
            vim.keymap.set("t", keys, "<C-\\><C-n>" .. action, {
                noremap = true,
                silent = true,
                desc = "ToggleTerm: " .. desc
            })
        end
        keymap('<F9>', ':TermNew<cr>', 'Open New Terminal')
        keymap('<F10>', ':TermSelect<cr>', 'Select Terminal')
        keymap('<F12>', ':ToggleTerm<cr>', 'Toggle Terminal')
    end,
}
