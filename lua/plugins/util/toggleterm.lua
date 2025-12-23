return {
    'akinsho/toggleterm.nvim',
    event = vim.g.open_file_evt,
    cmd = "IPRepl",
    config = function()
        require('toggleterm').setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return vim.g.hspsize
                elseif term.direction == "vertical" then
                    return 70
                end
            end,
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
