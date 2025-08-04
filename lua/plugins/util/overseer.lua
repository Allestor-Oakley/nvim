return {
    'stevearc/overseer.nvim',
    cmd = {
        "OverseerOpen", "OverseerClose",
        "OverseerToggle", "OverseerSaveBundle",
        "OverseerLoadBundle", "OverseerDeleteBundle",
        "OverseerRunCmd", "OverseerRun",
        "OverseerInfo", "OverseerBuild",
        "OverseerQuickAction", "OverseerTaskAction",
        "OverseerClearCache",
    },
    keys = {
        { '<leader>tr', ":OverseerRun<cr>", desc = "Overseer: [r]un task" }
    },
    config = function()
        local overseer = require('overseer')
        overseer.setup({
            strategy = "toggleterm",
            templates = { 'builtin' }
        })

        -- Run Command
        vim.api.nvim_create_user_command('RCI', function(_)
            vim.ui.input({ prompt = 'Insert your g:RunCommand' }, function(input)
                if input ~= nil then
                    vim.g.RunCommand = input
                end
            end)
        end, {})
        overseer.register_template(require("plugins.components.run_command_templ"))
    end,
}
