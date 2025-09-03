local obsidian_workspaces = require("plugins.components.user").ObsidianWorkspaces

return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        event = function()
            local final = {}
            for _, v in ipairs(obsidian_workspaces) do
                local path = v.path:gsub("\\", "/")
                final[#final + 1] = "BufReadPre " .. path .. "/**/*.md"
                final[#final + 1] = "BufNewFile " .. path .. "/**/*.md"
            end
            return final
        end,
        opts = {
            legacy_commands = false,
            footer = {
                enabled = false
            },
            workspaces = obsidian_workspaces,
        },
    },
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
