return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = "classic",
            transparent_bg = true,
            options = {
                multilines = {
                    enabled = true,
                    always_show = true,
                },
            }
        })
        vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextArrow", { bg = nil })
    end
}
