-- Python repl keymaps
vim.keymap.set("n", "<NL>", function()
    -- check if ipython exist, if not, open a new ipython repl
    local toggleterm_ok, toggleterm_terminal = pcall(require, "toggleterm.terminal")
    if toggleterm_ok then
        local terms = toggleterm_terminal.get_all()
        local iprepl_exist = false
        for _, v in pairs(terms) do
            if v["cmd"] then
                if string.find(v["cmd"], "ipython") then
                    iprepl_exist = true
                    break
                end
            end
        end
        if not iprepl_exist then
            vim.cmd [[IPRepl]]
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<C-\\><C-n><C-w><c-p>", true, true, true),
                "n",
                true
            )
        end
    end
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
