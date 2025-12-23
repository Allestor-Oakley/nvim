local function feedkeys(prompt)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(prompt, true, true, true),
        "n",
        true
    )
end
-- check if ipython exist, if not, open a new ipython repl
local function check_summon_iprepl()
    local toggleterm_ok, toggleterm_terminal = pcall(require, "toggleterm.terminal")
    if not toggleterm_ok then
        return
    end

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
        feedkeys("<C-\\><C-n><C-w><c-p>")
    end
end
local function send_visual_to_iprepl()
    feedkeys(":'<,'>lua require('plugins.components.send_to_ipython').send_lines_to_ipython()<cr>")
end

vim.api.nvim_create_user_command("IPRepl", function()
    local toggleterm_ok, _ = pcall(require, "toggleterm.terminal")
    if not toggleterm_ok then
        return
    end

    local Terminal = require('toggleterm.terminal').Terminal
    local ipdtsc   = Terminal:new({
        cmd = "conda activate dtsc && ipython --no-autoindent --nosep --no-banner",
        hidden = false,
        direction = "vertical",
        auto_scroll = true,
    })

    ipdtsc:toggle()
end, {})

-- Python repl keymaps
vim.keymap.set("n", "<NL>", function()
    check_summon_iprepl()
    feedkeys("v/^# %%<cr>kogNj")
    send_visual_to_iprepl()
end, { silent = true, buffer = 0 })
vim.keymap.set("v", "<NL>", function()
    check_summon_iprepl()
    send_visual_to_iprepl()
end, { silent = true, buffer = 0 })
vim.keymap.set("n", "gcy", "o<esc>0i# %% <esc>60a-<esc>", { buffer = 0 })
