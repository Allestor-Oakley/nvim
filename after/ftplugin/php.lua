vim.opt_local.ft = "phtml"
vim.opt_local.autoindent = true
vim.opt_local.copyindent = true
vim.opt_local.smartindent = false
vim.keymap.set("n", "cc", '"_ddko', {
    noremap = true, buffer = true
})
