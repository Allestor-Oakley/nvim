-- Taken from alpha.themes.dashboard
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl = "SectionWhite",
        hl_shortcut = "SectionPurple",
    }
    if keybind then
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local function get_logo(logo, color_list)
    for i, v in ipairs(color_list) do
        vim.api.nvim_set_hl(0, "StartLogo" .. i, { fg = v })
    end
    local lines = {}
    for i, chars in ipairs(logo) do
        local line = {
            type = "text",
            val = chars,
            opts = {
                hl = "StartLogo" .. i,
                shrink_margin = false,
                position = "center"
            }
        }
        table.insert(lines, line)
    end

    return lines
end

local function get_stats(lazy_perf)
    local plugins = " " .. #require("lazy").plugins() .. " plugins"
    local date = os.date(" %a, %d %b %Y")
    local spacer = "     "
    local lazy_stat = " " .. lazy_perf .. "ms"
    return date .. spacer .. " " .. plugins .. spacer .. lazy_stat
end

local function alpha_config()
    -- setting up alpha.nvim
    vim.cmd [[
    autocmd User AlphaReady set laststatus=0
    autocmd User AlphaClosed set laststatus=3
    hi Normal guibg=NONE
    hi CursorLineNr guibg=NONE
    ]]

    -- Highlight
    vim.api.nvim_set_hl(0, "SectionPurple", { fg = "#C147E9", bg = nil })
    vim.api.nvim_set_hl(0, "SectionWhite", { fg = "#abb2bf", bg = nil })

    local section = {}

    -- 82 x 21
    local logo_planet = {
        [[      ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿      ]],
        [[     ╱              '          .     @         #      ()       "  |         ╲     ]],
        [[    ╱   "      #           "             '                      - o -      0 ╲    ]],
        [[   ╱, o              ()     o  ,           "   *    ,     _.oo.   |    '      ╲   ]],
        [[  ╱       .  |                    _.u///;:,.         .odmmmmmm'  +         o  .╲  ]],
        [[ ╱  /  '   - o -   "   @    +   .o888uu[[[/;:-.  .o@p^    mmm^           #      ╲ ]],
        [[▕  ╱  ,      |            ,    on88888uu[[[/;::-.        dp^        '        .  ▕ ]],
        [[▕ o      .         /          dnmmnn888uu[[[/;:--.   .o@p^    "         *  \    ▕ ]],
        [[▕            "    /       "  ,mmmmmmn888uu[[/;::-. o@^            ()        \ " ▕ ]],
        [[▕ #     *        /    #      nnmmmnn888uu[[[/~.o@p^    .    #   .            \  ▕ ]],
        [[▕               +            88[888888uu[[[/o@^-..                      '  @  \ ▕ ]], --middle
        [[▕     "    '      .    *    oi8888uu[[[/o@p^:--...        |     @   ^  .       O▕ ]],
        [[▕ ^                      .@^  yuu[[[/o@^;::---...    '    |                     ▕ ]],
        [[▕    o  ()    *    ,   omp     ^/o@p^;:::---....       -- O --       *  |   *   ▕ ]],
        [[▕ .                 .dmmm    .o@^ ^;::---.....   .        |   +        -o-     "▕ ]],
        [[ ╲   ,  |     @    dmmmmmmm@^`       ``^^^^               |     #       |     . ╱ ]],
        [[  ╲    -o- '      ommmup^                       ,   #              \      ()   ╱  ]],
        [[   ╲ .  |          ^^        /      ()    *             *    ()     \  ,      ╱   ]],
        [[    ╲      "  .        #    /    o                       ,           o      0╱    ]],
        [[     ╲  '   #     *        @           .     @     +        .   '     .  "  ╱     ]],
        [[      ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣      ]],
    }
    local logo_colors = {
        "#2D2671",
        "#352770",
        "#3C2870",
        "#44296F",
        "#4B296E",
        "#532A6E",
        "#5A2B6D",
        "#622C6C",
        "#692D6C",
        "#712E6B",
        "#782F6B",
        "#802F6A",
        "#873069",
        "#8F3169",
        "#963268",
        "#9E3367",
        "#A53467",
        "#AD3466",
        "#B43565",
        "#BC3665",
        "#C33764"
    }
    local welcome_msg = "    [   Welcome back!   ]    "
    local username = require("plugins.components.user").UserName
    if username ~= nil then
        welcome_msg = "    [   Welcome back, " .. username .. "!   ]    "
    end

    -- Get possession last session
    local path = require("plugins.components.user").LastSessionTracker
    local file = io.open(path, "r")
    local last_session = ""
    if file ~= nil then
        io.input(file)
        last_session = io.read()
        io.close(file)
    end

    section.logo = { type = "group", val = get_logo(logo_planet, logo_colors) }
    section.buttons = {
        type = "group",
        val = {
            button("l", "󰑙  Last project (" .. last_session .. ")",
                "<cmd>PossessionLoad " .. last_session .. "<CR>"),
            button("e", "  New file", "<cmd>ene <CR>"),
            button("SPC f f", "  Find file"),
            button("SPC f g", "  Find word"),
            button("SPC f p", "  Find project"),
            button("SPC ?  ", "  Open settings"),
            button("q", "󰗼  Quit", "<cmd>q <CR>"),
        },
        opts = {
            spacing = 1,
        },
    }
    section.welcome = { type = "text", val = welcome_msg, opts = { hl = "SectionPurple", position = "center" } }
    section.stat = { type = "text", val = get_stats(0), opts = { hl = "SectionPurple", position = "center" } }

    -- for updating section.stat
    vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            section.stat.val = get_stats(ms)
            pcall(vim.cmd.AlphaRedraw)
        end,
    })

    require 'alpha'.setup({
        layout = {
            { type = "padding", val = 6 },
            section.logo,
            { type = "padding", val = 2 },
            section.welcome,
            { type = "padding", val = 2 },
            section.buttons,
            { type = "padding", val = 2 },
            section.stat,
            { type = "padding", val = 22 },
        },
        opts = {
            margin = 5
        }
    })
end

return {
    'goolord/alpha-nvim',
    lazy = false,
    config = alpha_config,
}
