local options = {
    updatetime = 150,

    ignorecase = true,
    smartcase = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,

    number = true,
    relativenumber = true,
    signcolumn = "yes",

    showmode = false,
    swapfile = false,
    wrap = false,
    hlsearch = false,

    termguicolors = true,
    background = "dark",

    ruler = false,
    showcmd = true,

    pumblend = 0,
    winblend = 0,
    pumheight = 10,
    pumwidth = 10,

    scrolloff = 4,

    completeopt = { "longest", "menuone" },

    showmatch = true,
}
for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.sessionoptions:append({ "globals" })
vim.opt.sessionoptions:remove({ "help" })

for _, v in ipairs({ "W", "F", "c", "a", "I" }) do
    table.insert(vim.opt.shortmess, v)
end

vim.cmd("filetype plugin indent on")
vim.cmd('set shada="NONE"')
vim.cmd('set guicursor+=c-t:ver25')
