-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, desc = "which_key_ignore" }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- For function keys
map("n", "<F11>", "", { desc = "Fullscreen" })

-- Git diff
map("n", "<leader>gj", ":diffget //3<CR>", { desc = "Git: Diff from Right" })
map("n", "<leader>gf", ":diffget //2<CR>", { desc = "Git: Diff from Left" })

-- Quickfix list and Location list
map("n", "<leader>[[", ":lprev<CR>", { silent = true })
map("n", "<leader>]]", ":lnext<CR>", { silent = true })
map("n", "<leader>,,", ":cprev<CR>", { silent = true })
map("n", "<leader>..", ":cnext<CR>", { silent = true })
map("n", "<leader>,.", function()
    vim.cmd [[
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    ]]
end, { silent = true })

-- Replace
map("v", "<C-h>", '"hy:%s/<C-r>h//gc<left><left><left>')
map("n", "<C-h>", ":%s/")

-- Copy
map("n", "<leader>y", '"*y')
map("v", "<leader>y", '"*y')
map("n", "<leader>Y", '"+Y')

-- Paste
map("n", "<leader>p", '"*p')
map("x", "<leader>p", '"_dP"')

-- Delete and cut
map("n", "<leader>d", '"_d')
map("x", "<leader>d", '"_d')
map("n", "<leader>D", '"_D')
map("x", "<leader>D", '"_D')

-- New Line
map("n", "<leader>o", 'o<ESC>')
map("n", "<leader>O", 'O<ESC>')

-- Change
map("n", "c", '"_c')
map("n", "C", '"_C')
map("x", "c", '"_c')
map("x", "C", '"_C')

-- Movement
map("n", "n", 'nzzzv')
map("n", "N", 'Nzzzv')

-- Moving text
map("n", "J", "mzJ`z")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("i", "<C-j>", ":m .+1<CR>==")
map("i", "<C-k>", ":m .-2<CR>==")
map("n", "<C-j>", ":m .+1<CR>==")
map("n", "<C-k>", ":m .-2<CR>==")

-- Undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "]", "]<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "(", "(<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "{", "{<c-g>u")
map("i", "}", "}<c-g>u")

-- Save
map("n", "<leader>we", ":write<CR>", { silent = true })
map("n", "<leader>wa", ":noautocmd write<CR>", { silent = true })

-- Change windows
map("n", "<leader>w", "<C-w>")

-- Play macro
map("n", "Q", "@", { desc = "Play Macro" })

vim.cmd([[
" Skip semicolon if it already typed
inoremap <expr> ; getline(".")[col(".")-1] == ';' ? '<Right>' : ';'

" Command redirect
cnoremap <expr> <S-Enter> ':<C-u>Redir '.getcmdline().'<CR>'
]])

-- Keep visual mode after indent
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Up and down page
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Tab navigation
map("n", "<leader>tc", ":tabnew<CR>", { silent = true, desc = "Tab: [c]reate" })
map("n", "<leader>td", ":tabclose<CR>", { silent = true, desc = "Tab: [d]elete" })
map("n", "<leader>tn", ":tabnext<CR>", { silent = true, desc = "Tab: [n]ext" })
map("n", "<leader>tp", ":tabprev<CR>", { silent = true, desc = "Tab: [p]rev" })
for i = 1, 5 do
    map("n", "<leader>t" .. i, ":" .. i .. "tabnext<cr>", { desc = "Tab: Go To " .. i })
end

-- TODO: fix issue where notiifcation cause this function to be useless
-- Modified quit window
map("n", "<leader>wq", function()
    -- if the current window isn't a sidebar, continue checking
    if not vim.g.sidebar_ft[vim.bo.filetype] then
        local wins = vim.api.nvim_tabpage_list_wins(0)
        local sidebar_win = {}
        for _, winid in ipairs(wins) do
            -- if the window is not the current window, continue with the checking
            if vim.api.nvim_win_is_valid(winid) and winid ~= vim.api.nvim_get_current_win() then
                local filetype = vim.bo[vim.api.nvim_win_get_buf(winid)].filetype
                -- if there is other window which the filetype
                -- wasn't sidebar, close it and end the function
                if vim.g.sidebar_ft[filetype] == nil then
                    vim.cmd [[q]]
                    return
                else
                    sidebar_win[#sidebar_win + 1] = winid
                end
            end
        end
        -- if the function still progress untill now, then there is no other window
        -- other than the current window, so quit all sidebar windows
        for _, winid in ipairs(sidebar_win) do
            vim.api.nvim_win_close(winid, true)
        end
    end
    -- if the current window is sidebar, or it is the last non-sidebar window
    vim.cmd [[q]]
end)
---@format disable-next
vim.g.sidebar_ft = {
    dapui_watches = true, dapui_stacks = true, dapui_breakpoints = true,
    dapui_scopes = true, dapui_console = true, ["dap-repl"] = true,
    toggleterm = true, ["neo-tree"] = true, notify = true,
    ["neotest-summary"] = true, ["neotest-output-panel"] = true,
    trouble = true, dbui = true, help = true, qf = true
}

-- Resizing split more consistently
-- dir is either "vertical" or "horizontal"
-- operation is either "+" or "-"
local function resize_split(dir, operation)
    local resize_command = "resize "
    if dir == "vertical" then
        resize_command = "vert " .. resize_command
    end
    local size = (dir == "vertical") and "5" or "2"

    -- check if the split is the most right or the most bottom
    local at_the_edge = false
    if dir == "vertical" then
        at_the_edge = vim.fn.winnr() == vim.fn.winnr("l")
    else
        at_the_edge = vim.fn.winnr() == vim.fn.winnr("j")
    end

    -- Stop, if there is no horizontal split and the move is horizontal
    if at_the_edge and dir == "horizontal" then
        if vim.fn.winnr() == vim.fn.winnr("k") then
            return
        end
    end

    -- Inverse operation if at the edge
    if at_the_edge then
        operation = (operation == "+") and "-" or "+"
    end

    vim.cmd(resize_command .. operation .. size)
end

map("n", "<M-down>", function() resize_split('horizontal', '+') end, { silent = true, desc = "Split: Resizing Down" })
map("n", "<M-up>", function() resize_split('horizontal', '-') end, { silent = true, desc = "Split: Resizing Up" })
map("n", "<M-right>", function() resize_split('vertical', '+') end, { silent = true, desc = "Split: Resizing Right" })
map("n", "<M-left>", function() resize_split('vertical', '-') end, { silent = true, desc = "Split: Resizing Left" })
