return {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
        timeout = 1,
        maxkeys = 5,
        position = "top-right",
    },
    keys = {
        { "<A-?>", ":ShowkeysToggle<cr>", desc = "Showkeys: Toggle", silent = true }
    }
}
