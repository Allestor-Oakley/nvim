vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = 'black' })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = 'black' })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelp', { bg = 'black' })
vim.api.nvim_set_hl(0, 'BlinkCmpKind', { bg = 'black' })

local opts = {
    snippets = { preset = 'luasnip' },
    keymap = {
        preset = "enter",
        ['<s-tab>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<tab>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-a>'] = { 'snippet_backward', 'fallback' },
        ['<C-s>'] = { 'snippet_forward', 'fallback' },
    },
    completion = {
        list = {
            selection = { preselect = false, auto_insert = true }
        },
        menu = {
            winblend = 10,
            border = 'rounded',
            draw = {
                padding = { 0, 1 }, -- padding only on right side
                components = {
                    kind_icon = {
                        text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end
                    }
                }
            }
        },
        documentation = {
            window = {
                winblend = 10,
                border = 'rounded',
            }
        },
    },
    signature = {
        enabled = true,
        window = {
            winblend = 10,
            border = 'rounded',
        }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
            sql = { 'snippets', 'dadbod', 'buffer' },
        },
        providers = {
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
    },
}

return {
    'saghen/blink.cmp',
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*', lazy = true },
    },
    version = '1.*',
    opts = opts,
    event = vim.g.open_file_evt
}
