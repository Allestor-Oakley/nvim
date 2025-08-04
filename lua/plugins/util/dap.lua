local dap_conf = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes",      size = 0.28 },
                    { id = "breakpoints", size = 0.24 },
                    { id = "stacks",      size = 0.24 },
                    { id = "watches",     size = 0.24 }
                },
                position = "left",
                size = vim.g.vspsize
            },
            {
                elements = {
                    { id = "repl",    size = 0.5 },
                    { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = vim.g.hspsize
            }
        },
    })
    require('nvim-dap-virtual-text').setup({
        commented = true
    })
    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end
    require("overseer").enable_dap()

    -- Signs
    vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    })

    vim.fn.sign_define("DapLogPoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
    })

    -- Python
    local dap_python = require('dap-python')
    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                return require("plugins.components.python_env")("dap-python")
            end,
        },
    }
    dap_python.setup('python')
end

local keymap = require("plugins.components.gen_keymap")("DAP")
return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "nvim-neotest/nvim-nio",
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        -- specific lang
        { 'mfussenegger/nvim-dap-python', lazy = true },
        -- overseer
        'stevearc/overseer.nvim'
    },
    keys = {
        keymap('<leader>\\d', function() require("dap").clear_breakpoints() end, '[d]elete all breakpoint'),
        keymap('<leader>\\b', function() require("dap").toggle_breakpoint() end, 'Toggle [b]reakpoint'),
        keymap('<leader>\\c', function()
            vim.ui.input({ prompt = "Breakpoint condition" }, function(input)
                if input ~= nil then require("dap").set_breakpoint(input) end
            end)
        end, 'Set [c]onditional breakpoint'),
        keymap('<Leader>\\l', function()
            vim.ui.input({ prompt = "[L]ogpoint message" }, function(input)
                if input ~= nil then require("dap").set_breakpoint(nil, nil, input) end
            end)
        end, 'Set [l]ogpoint'),

        keymap('<F5>', function() require("dap").continue() end, 'Continue'),
        keymap('<F6>', function() require("dap").step_into() end, 'Step Into'),
        keymap('<F7>', function() require("dap").step_over() end, 'Step Over'),
        keymap('<F8>', function() require("dap").step_out() end, 'Step Out'),

        keymap('<leader>\\s', function() vim.cmd [[DapNew]] end, '[S]tart debugger'),
        keymap('<leader>\\r', function() require("dap").restart() end, '[R]estart'),
        keymap('<leader>\\q', function() require("dap").terminate() end, '[Q]uit debugger'),
        keymap('<leader>\\u', function() require("dapui").toggle() end, 'Toggle dap[u]i'),
    },
    config = dap_conf,
}
