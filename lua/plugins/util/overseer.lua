-- Run Command
vim.api.nvim_create_user_command('RCI', function(_)
    vim.ui.input({ prompt = 'Insert your g:RunCommand' }, function(input)
        if input ~= nil then
            vim.g.RunCommand = input
        end
    end)
end, {})

return {
    'stevearc/overseer.nvim',
    cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerRun",
        "OverseerTaskAction",
    },
    lazy = false,
    keys = {
        { '<leader>tr', ":OverseerRun<cr>",    desc = "Overseer: [r]un task" },
        { '<leader>tl', ":OverseerToggle<cr>", desc = "Overseer: task [l]ist" }
    },
    config = function()
        local overseer = require('overseer')
        overseer.setup({
            dap = false,
            task_list = {
                min_height = vim.g.hspsize
            },
        })

        overseer.register_template(require("plugins.components.run_command_templ"))
    end,
}
