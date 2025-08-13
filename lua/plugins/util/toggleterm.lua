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
        vim.keymap.set("v", "<A-F12>",
            ":'<,'>lua require('plugins.components.send_to_ipython').send_lines_to_ipython()<cr>"
            , { silent = true })
        -- Auto in insert mode when changing to terminal
        vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "toggleterm" then
                    vim.defer_fn(function()
                        vim.cmd.startinsert()
                    end, 50)
                end
            end
        })
    end,
}
