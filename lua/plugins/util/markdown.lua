return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
        opts = {
            preset = 'obsidian',
            completions = { blink = { enabled = true } },
            code = {
                language_border = '',
            },
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = nil })
            require('render-markdown').setup(opts)
        end
    },
}
