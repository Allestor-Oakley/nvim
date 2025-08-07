return {
    'piersolenski/import.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    opts = {
        picker = "telescope",
    },
    keys = {
        { "<leader>fi", function() require("import").pick() end, desc = "Telescope: [I]mport", },
    },
}
