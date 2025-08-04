local keymap = require("plugins.components.gen_keymap")("Neotest")
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Specific lang
        "nvim-neotest/neotest-python",
    },
    cmd = "Neotest",
    keys = {
        keymap("<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, "Run [F]ile"),
        keymap("<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, "Run all [T]est files"),
        keymap("<leader>tt", function() require("neotest").run.run() end, "Run Nearest [t]est"),
        keymap("<leader>ts", function() require("neotest").summary.toggle() end, "Toggle [s]ummary"),
        keymap("<leader>to", function() require("neotest").output_panel.toggle() end, "Toggle [o]utput panel"),
    },
    config = function()
        vim.cmd [[let test#strategy = "toggleterm"]]
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                    python = function()
                        return require("plugins.components.python_env")("neotest")
                    end,

                }),
            },
            output_panel = {
                enabled = true,
                open = "botright split | resize " .. vim.g.hspsize
            },
            summary = {
                open = "topleft vsplit | vertical resize " .. vim.g.vspsize
            }
        })
    end,
}
