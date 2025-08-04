local lualine_conf = function()
    vim.opt.laststatus = 3

    local custom_auto = require 'lualine.themes.auto'
    local modes = { "normal", "insert", "replace", "visual", "command", "inactive" }
    local sections = { "b", "c", "x", "y" }
    -- For transparency
    for _, mode in ipairs(modes) do
        for _, section in ipairs(sections) do
            if custom_auto[mode][section] ~= nil then
                custom_auto[mode][section].bg = nil
                custom_auto[mode][section].fg = "#99adad"
            end
        end
        custom_auto[mode]["a"].gui = "bold"
    end

    local mode_map = {
        ['NORMAL']    = '  ᕕ( ᐛ  )ᕗ ',
        ['O-PENDING'] = '  (ㆆ _ ㆆ)',
        ['INSERT']    = '  ᕕ(⌐■_■)ᕗ ',
        ['VISUAL']    = '   (/≧▽≦)/ ',
        ['V-BLOCK']   = '  o(*≧▽≦)/ ',
        ['V-LINE']    = ' ~\\(≧▽≦)/~ ',
        ['V-REPLACE'] = '   (≧∀≦)ゞ ',
        ['REPLACE']   = '  (┬┬﹏┬┬) ',
        ['COMMAND']   = '  ᕦ(^ò_ó)ᕤ ',
        ['SHELL']     = '  (σ｀д′)  ',
        ['TERMINAL']  = '  o( >ω<)o ',
        ['EX']        = '  w( >ω<)W',
        ['S-BLOCK']   = '   (⊙ˍ⊙)   ',
        ['S-LINE']    = '   (⊙_⊙)？ ',
        ['SELECT']    = '   (⊙_⊙;)  ',
        ['CONFIRM']   = ' (lll￢ω￢)',
        ['MORE']      = '  ╮(╯-╰)╭  ',
    }
    local function git_info()
        local git_status = vim.b.gitsigns_status_dict
        local b = " " .. git_status.head
        local a = "%#diffAdded#+" .. (git_status.added or 0)
        local c = "%#diffChanged# ~" .. (git_status.changed or 0)
        local r = "%#diffRemoved# -" .. (git_status.removed or 0)
        if git_status then
            return b .. " (" .. a .. c .. r .. "%#lualine_c_normal#)"
        end
        return ''
    end

    local function session_name()
        return ' ' .. (require('possession.session').get_session_name() or '-')
    end

    local function diagnostic_info()
        local vd = vim.diagnostic
        local dg = vd.count(0)
        local counts = {
            "" .. (dg[vd.severity.ERROR] or 0),
            " " .. (dg[vd.severity.WARN] or 0),
            " " .. (dg[vd.severity.INFO] or 0),
            " 󰌶" .. (dg[vd.severity.HINT] or 0),
        }
        local hi = {
            "%#DiagnosticError#",
            "%#DiagnosticWarn#",
            "%#DiagnosticInfo#",
            "%#DiagnosticHint#",
        }
        for i, val in ipairs(counts) do
            if string.match(val, "%d+") ~= "0" then
                counts[i] = hi[i] .. val
            else
                counts[i] = "%#Comment#" .. val
            end
        end
        return table.concat(counts) .. "%#lualine_c_normal#"
    end

    local function lightbulb()
        return "act: %#LightBulbSign#" .. require('nvim-lightbulb').get_status_text()
    end

    --- Give color
    ---@param color string
    ---@return table
    local function gc(color)
        return {
            fg = color,
            gui = "NONE"
        }
    end

    require("lualine").setup({
        options = {
            theme = custom_auto,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(s) return mode_map[s] or s end,
                    separator = { right = '' }
                },
            },
            lualine_b = {
                git_info,
                diagnostic_info,
            },
            lualine_c = {
                {
                    'filename',
                    color = gc(custom_auto["command"]["a"].bg),
                },
            },
            lualine_x = {
                {
                    'location',
                    color = gc(custom_auto["visual"]["a"].bg),
                },
                {
                    'progress',
                    color = gc(custom_auto["visual"]["a"].bg),
                },
            },
            lualine_y = {
                {
                    session_name,
                    color = gc(custom_auto["replace"]["a"].bg),
                },
                {
                    '"󰧚 "..#require("toggleterm.terminal").get_all(true)',
                    color = gc(custom_auto["normal"]["a"].bg),
                },
                lightbulb,
                'filetype',
            },
            lualine_z = {
                {
                    '%{strftime("%H:%M")}',
                    separator = { left = '' }
                }
            },
        },
    })
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = vim.g.open_file_evt,
    commit =
    "834a5817f7e2be22a7062620032d49c600c35fab", -- statusline sometimes dissapeared when entering command mode
    config = lualine_conf
}
