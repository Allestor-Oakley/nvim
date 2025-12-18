return {
    "nvzone/menu",
    dependencies = {
        { "nvzone/volt", lazy = true },
    },
    lazy = true,
    keys = {
        {
            "<RightMouse>",
            mode = { "n", "v" },
            function()
                local default_opts = { mouse = true, border = true }
                require('menu.utils').delete_old_menus()

                vim.cmd.exec '"normal! \\<RightMouse>"'

                local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
                -- for neotree
                if vim.bo[buf].ft == "neo-tree" then
                    require("menu").open("neo-tree", default_opts)
                else
                    require("menu").open("default", default_opts)
                end
            end,
            desc = "Menu: Open"
        }
    },
    config = true
}
