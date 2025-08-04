-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.ignoreftfold = { "nvcheatsheet", "neo-tree", "alpha", "telescopeprompt", "outline", "lazygit", "toggleterm" }
vim.g.open_file_evt = { "BufReadPre", "InsertEnter" }
vim.g.vspsize = require("plugins.components.user").Size.VerticalSplit
vim.g.hspsize = require("plugins.components.user").Size.HorizontalSplit
vim.g.flsize = require("plugins.components.user").Size.Float
vim.g.CondaPrefixPath = require("plugins.components.user").CondaPrefixPath
vim.g.PythonPath = require("plugins.components.user").PythonPath

require("lazy").setup({
    spec = {
        { import = "plugins.ui" },
        { import = "plugins.editing" },
        { import = "plugins.util" },
        { import = "plugins.lsp" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false, notify = false },
    ui = {
        border = "rounded",
        size = {
            width = vim.g.flsize,
            height = vim.g.flsize,
        }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin", "getscript", "getscriptPlugin", "gzip",
                "logipat", "netrw", "netrwPlugin", "netrwSettings",
                "netrwFileHandlers", "matchit", "tar", "tarPlugin",
                "rrhelper", "vimball", "vimballPlugin", "zip",
                "zipPlugin", "tutor", "tohtml", "shada", "spellfile"
            },
        }
    }
})
vim.keymap.set("n", "<leader>lz", ":Lazy<cr>", { desc = "Lazy: Open", silent = true })
