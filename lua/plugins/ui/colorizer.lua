return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = {
            "*",
            "!mason",
            "!lazy",
            "lazygit",
            "toggleterm",
            "alpha",
            "neo-tree"
        }
    },
}
