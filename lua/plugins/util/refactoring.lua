local function keymap(keys, action, desc)
    return {
        keys,
        mode = { "n", "x" },
        function() return action end,
        noremap = true,
        silent = true,
        desc = "Refactor: " .. desc,
        expr = true
    }
end

return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        keymap("<leader>re", function()
            return require('refactoring').refactor('Extract Function')
        end, "[E]xtract function"),
        keymap("<leader>rf", function()
            return require('refactoring').refactor('Extract Function To File')
        end, "Extract function to [f]ile"),

        keymap("<leader>rv", function()
            return require('refactoring').refactor('Extract Variable')
        end, "Extract [V]ariable"),

        keymap("<leader>ri", function()
            return require('refactoring').refactor('Inline Variable')
        end, "Inline Variable"),
        keymap("<leader>rI", function()
            return require('refactoring').refactor('Inline Function')
        end, "Inline Function"),

        keymap("<leader>rb", function()
            return require('refactoring').refactor('Extract Block')
        end, "Extract [B]lock"),
        keymap("<leader>rt", function()
            return require('refactoring').refactor('Extract Block To File')
        end, "Extract Block [t]o file"),
        {
            "<leader>rr",
            mode = { "n", "x" },
            function() require('refactoring').select_refactor() end,
            desc = "Refactor: Select [R]efactor",
            silent = true,
        }
    },
    config = function()
        require('refactoring').setup({})
    end
}
