return {
    'jedrzejboczar/possession.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    cmd = {
        'PossessionSave', 'PossessionLoad',
        'PossessionSaveCwd', 'PossessionLoadCwd',
        'PossessionRename', 'PossessionClose',
        'PossessionDelete', 'PossessionShow',
        'PossessionPick', 'PossessionList',
        'PossessionListCwd', 'PossessionMigrate',
    },
    keys = {
        {
            "<leader>?",
            function()
                vim.cmd([[PossessionClose]])
                vim.cmd([[PossessionLoad nvimrc]])
            end,
            desc = "Possession: Open Setting"
        },
    },
    event = vim.g.open_file_evt,
    opts = {
        autosave = {
            current = true,
        },
        plugins = {
            delete_hidden_buffers = {
                hooks = {}
            },
            neotest = false,
            neo_tree = false,
            dap = false,
            dapui = false,
        },
        hooks = {
            before_load = function(_, user_data)
                vim.cmd [[PossessionClose]]
                vim.cmd [[unlet! g:RunCommand]]
                return user_data
            end,
            after_load = function(name, _)
                local file = io.open(require("plugins.components.user").LastSessionTracker, "w")
                if file == nil then return end
                file:write(name)
                file:close()
            end
        }
    }
}
