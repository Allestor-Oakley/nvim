local keymap = require("plugins.components.gen_keymap")("Neogen")

return {
    "danymat/neogen",
    config = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
        keymap("<leader>ld", function() require("neogen").generate() end, "Generate annotations")
    },
    cmd = "Neogen"
}
