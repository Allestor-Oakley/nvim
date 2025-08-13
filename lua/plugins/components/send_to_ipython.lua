-- stolen from: https://github.com/akinsho/toggleterm.nvim/issues/425#issuecomment-1650356215
local is_whitespace = function(str)
    return str:match("^%s*$") ~= nil
end
local trim_whitespace_strings = function(lines)
    local start_idx, end_idx = 1, #lines

    -- Find the index of the first non-whitespace string
    while start_idx <= #lines and is_whitespace(lines[start_idx]) do
        start_idx = start_idx + 1
    end

    -- Find the index of the last non-whitespace string
    while end_idx >= 1 and is_whitespace(lines[end_idx]) do
        end_idx = end_idx - 1
    end

    -- Create a new table containing only the non-whitespace strings
    local trimmed_lines = {}
    for i = start_idx, end_idx do
        table.insert(trimmed_lines, lines[i])
    end

    return trimmed_lines
end
return {
    send_lines_to_ipython = function()
        if vim.bo.filetype ~= "python" then
            vim.notify("not a python file", 3, { title = " Send To IPython" })
            return
        end

        local id = 1

        local current_window = vim.api.nvim_get_current_win() -- save current window

        local vstart = vim.fn.getpos("'<")
        local vend = vim.fn.getpos("'>")
        local line_start = vstart[2]
        local line_end = vend[2]
        local lines = vim.fn.getline(line_start, line_end)
        --
        local cmd = string.char(15)

        for _, line in ipairs(trim_whitespace_strings(lines)) do
            local l = line
            if l == "" then
                cmd = cmd .. string.char(15) .. string.char(14)
            else
                cmd = cmd .. l .. string.char(10)
            end
        end
        cmd = cmd .. string.char(4)
        require("toggleterm").exec(cmd, id)

        vim.api.nvim_set_current_win(current_window)
    end
}
