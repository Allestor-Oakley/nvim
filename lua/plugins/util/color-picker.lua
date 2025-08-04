return {
    {
        "nvzone/minty",
        dependencies = {
            { "nvzone/volt", lazy = true }
        },
        cmd = { "Shades", "Huefy" },
        keys = {
            { "<leader>c",  "",            desc = "+Color Picker Minty" },
            { "<leader>cs", ":Shades<cr>", desc = "Minty: Shades" },
            { "<leader>ch", ":Huefy<cr>",  desc = "Minty: Huefy" },
        }
    }
}
