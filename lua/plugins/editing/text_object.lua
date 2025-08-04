return {
    -- Text objects
    {
        "wellle/targets.vim",
        event = vim.g.open_file_evt
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = vim.g.open_file_evt,
        config = function()
            require("various-textobjs").setup({
                keymaps = {
                    useDefaults = true,
                    disabledDefaults = { "ic", "ac", "r", "R", "i,", "a," },
                }
            })
            vim.keymap.set({ "o", "x" }, "ic", function()
                require('plugins.components.mc_text_obj').multiCommentedLines(15)
            end)
        end
    },
}
