local create_ag = vim.api.nvim_create_augroup
local create_ac = vim.api.nvim_create_autocmd

local auGroup = create_ag("AllAu", { clear = true })

-- Remove trailing space
create_ac("BufWritePre", {
    group = auGroup,
    pattern = "*",
    callback = function()
        vim.cmd([[
            " Trim trailling space
            let ignoreFile = ['md', 'snippets']
            if index(ignoreFile, expand('%:e')) < 0
                let save = winsaveview()
                keeppatterns %s/\s\+$//e
                call winrestview(save)
            endif
        ]])
    end
})

-- PHP
create_ac({ "BufNewFile", "BufRead" }, {
    group = auGroup,
    pattern = "*.php",
    callback = function()
        vim.opt_local.ft = "phtml"
        vim.opt_local.autoindent = true
        vim.opt_local.copyindent = true
        vim.opt_local.smartindent = false
        vim.keymap.set("n", "cc", '"_ddko', {
            noremap = true, buffer = true
        })
    end
})

-- JSON
create_ac({ "BufNewFile", "BufRead" }, {
    group = auGroup,
    pattern = "*.json",
    callback = function()
        vim.opt_local.syntax = "jsonc"
    end
})

-- Qss
create_ac({ "BufNewFile", "BufRead" }, {
    group = auGroup,
    pattern = "*.qss",
    callback = function()
        vim.opt_local.ft = "qss"
        vim.opt_local.syntax = "css"
    end
})

-- Godot
create_ac("FileType", {
    group = auGroup,
    pattern = "gdscript",
    callback = function()
        vim.opt_local.commentstring = "#\\ %s"
    end
})

create_ac({ "BufNewFile", "BufRead" }, {
    group = auGroup,
    pattern = "*.md",
    callback = function()
        vim.opt_local.conceallevel = 2
    end
})

--  Quickfix list
create_ac("FileType", {
    group = auGroup,
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "q", '<CR>:ccl<CR>', { buffer = true })
        vim.cmd('call feedkeys("\\<C-w>\\<C-p>")')
        vim.opt_local.wrap = true
        vim.cmd('resize ' .. vim.g.hspsize)
    end
})

-- Restore cursor
create_ac("VimLeave", {
    group = auGroup,
    pattern = "*",
    callback = function()
        vim.cmd("set guicursor=a:ver25")
    end
})

-- Change cursorline based on mode
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
local function change_cursorlinenr()
    local colors = {
        green = "#89ca78",
        blue = "#61afef",
        comment = "#7f848e",
        yellow = "#e5c07b",
        red = "#ef596f"
    }
    local colors_table = {
        n = colors.green,
        t = colors.green,
        i = colors.blue,
        c = colors.comment,
        v = colors.yellow,
        V = colors.yellow,
        ["CTRL-V"] = colors.yellow,
        r = colors.red,
        R = colors.red,
    }
    local mode = vim.fn.mode()

    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors_table[mode], bg = nil })
end
create_ac("BufWinEnter", {
    group = auGroup,
    pattern = "*",
    callback = change_cursorlinenr
})
create_ac("ModeChanged", {
    group = auGroup,
    pattern = "*",
    callback = change_cursorlinenr
})

-- Disable fold in these filetypes
create_ac("FileType", {
    pattern = vim.g.ignoreftfold,
    callback = function()
        local ufo_loaded = require("lazy.core.config").plugins["nvim-ufo"]._.loaded
        if ufo_loaded then
            require("ufo").detach()
        end
        vim.opt_local.foldenable = false
    end
})
