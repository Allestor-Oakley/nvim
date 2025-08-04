return {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig", 'nvim-tree/nvim-web-devicons' },
    event = vim.g.open_file_evt,
    config = function()
        vim.api.nvim_set_hl(0, "NavicText", { fg = "#636363" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#636363" })

        local sep = "  "
        function Navic_FilePath()
            local path = vim.fn.expand("%:~:.")
            local filename = vim.fn.expand("%:t")
            local icon, color = require 'nvim-web-devicons'.get_icon_color(filename, vim.fn.expand("%:e"))
            if icon == nil then
                return filename
            end
            vim.api.nvim_set_hl(0, "NavicIconFile", { fg = color })
            path = path:gsub(filename:gsub("%p", "%%%1"), "") .. "%#MiniIconsPurple#" .. filename .. "%*"
            local result = "%#NavicIconFile# " .. icon .. "%* " .. path .. "%#NavicSeparator#" .. sep .. "%*"
            if result == "" then
                return ""
            end
            return result
        end

        require("nvim-navic").setup({
            highlight = true,
            separator = sep
        })

        vim.o.winbar = "%{%v:lua.Navic_FilePath()%}"
    end,
}
