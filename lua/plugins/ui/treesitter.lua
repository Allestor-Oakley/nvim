return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = vim.fn.argc(-1) == 0,
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.install'.prefer_git = false
        require('nvim-treesitter.install').compilers = { "zig" }

        require('nvim-treesitter.configs').setup({
            ensure_installed = require('plugins.components.ts_parsers'),
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = false
            },
        })
    end,
}
