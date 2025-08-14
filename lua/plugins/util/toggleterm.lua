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
        vim.keymap.set("n", "<NL>", function()
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("v/^# %%<cr>kogNj", true, true, true),
                "n",
                true
            )

            local prompt = ":'<,'>lua require('plugins.components.send_to_ipython').send_lines_to_ipython()<cr>"
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(prompt, true, true, true),
                "n",
                true
            )
        end, { silent = true })
        vim.api.nvim_create_user_command("IPRepl", function()
            local Terminal = require('toggleterm.terminal').Terminal
            local ipdtsc   = Terminal:new({
                cmd = "conda activate dtsc && ipython --no-autoindent --nosep --no-banner",
                hidden = false,
                direction = "vertical",
                auto_scroll = true,
            })

            ipdtsc:toggle()
        end, {})

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
