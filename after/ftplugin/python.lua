-- Python repl keymaps
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
end, { silent = true, buffer = 0 })
vim.keymap.set("n", "gcy", "o<esc>0i# %% <esc>60a-<esc>", { buffer = 0 })
