return {
    'kosayoda/nvim-lightbulb',
    dependencies = {
        { "aznhe21/actions-preview.nvim", lazy = true, event = vim.g.open_file_evt }
    },
    event = vim.g.open_file_evt,
    opts = function()
        vim.keymap.set(
            { "v", "n" },
            "<leader>la",
            require("actions-preview").code_actions,
            { noremap = true, silent = true, desc = "LSP: Code Action" }
        )
        return {
            autocmd = { enabled = true },
            sign = {
                enabled = false,
            },
            status_text = {
                enabled = true,
                text = "!",
                text_unavailable = " "
            },
        }
    end
}
