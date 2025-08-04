return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local keymap = function(keys, action, desc)
            vim.keymap.set({ "n", "x" }, keys, action,
                { noremap = true, silent = true, desc = "Refactor: " .. desc, expr = true })
        end

        vim.keymap.set(
            { "n", "x" },
            "<leader>rr",
            function() require('refactoring').select_refactor() end,
            {
                desc = "Refactor: Select [R]efactor",
                silent = true,
            }
        )
        keymap("<leader>re", function()
            return require('refactoring').refactor('Extract Function')
        end, "[E]xtract function")
        keymap("<leader>rf", function()
            return require('refactoring').refactor('Extract Function To File')
        end, "Extract function to [f]ile")

        keymap("<leader>rv", function()
            return require('refactoring').refactor('Extract Variable')
        end, "Extract [V]ariable")

        keymap("<leader>ri", function()
            return require('refactoring').refactor('Inline Variable')
        end, "Inline Variable")
        keymap("<leader>rI", function()
            return require('refactoring').refactor('Inline Function')
        end, "Inline Function")

        keymap("<leader>rb", function()
            return require('refactoring').refactor('Extract Block')
        end, "Extract [B]lock")
        keymap("<leader>rt", function()
            return require('refactoring').refactor('Extract Block To File')
        end, "Extract Block [t]o file")

        require('refactoring').setup({})
    end
}
