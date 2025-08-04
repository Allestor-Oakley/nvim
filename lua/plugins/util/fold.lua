return {
    {
        "kevinhwang91/nvim-ufo",
        event = "BufRead",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        ft_ignore = vim.g.ignoreftfold,
                        relculright = true,
                        segments = {
                            { text = { "%s" },                  click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                            { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                        },
                    })
                end,
            },
        },
        config = function()
            -- Fold options
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

            vim.o.foldenable = true
            vim.o.foldcolumn = "1"
            vim.o.foldlevelstart = 99
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            -- Prefer LSP folding if client supports it
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local win = vim.api.nvim_get_current_win()
                    vim.wo[win][0].foldlevel = 99
                    -- if client == nil then return end
                    ---@diagnostic disable-next-line
                    if client:supports_method('textDocument/foldingRange') then
                        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
                    end
                end,
            })

            require("ufo").setup()

            -- Keymaps
            vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = "UFO: Open All Fold" })
            vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = "UFO: Close All Fold" })
            vim.keymap.set('n', 'zK', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "UFO: Peak fold" })
        end,
    },
}
