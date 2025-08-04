return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim",           lazy = true },
        { "mason-org/mason-lspconfig.nvim", lazy = true },
    },
    event = vim.g.open_file_evt,
    keys = {
        { "<leader>lm", ":Mason<cr>", desc = "LSP: Open [M]ason", silent = true }
    },
    config = function()
        local servers = require("plugins.components.lsp_servers")
        local handlers = require("plugins.components.lsp_handlers")

        require("mason").setup({
            ui = {
                border = "rounded",
                width = vim.g.flsize,
                height = vim.g.flsize,
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
            automatic_enable = servers
        })

        local opts = {}
        for _, server in pairs(servers) do
            opts = {
                on_attach = handlers.on_attach,
                capabilities = handlers.capabilities,
            }
            server = vim.split(server, "@")[1]
            local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
            if require_ok then
                opts = vim.tbl_deep_extend("force", conf_opts, opts)
            end
            vim.lsp.config(server, opts)
        end

        handlers.setup()
    end,
}
