-- Help filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = "startuptime",
    callback = function()
        vim.defer_fn(
            function()
                vim.cmd("wincmd J || lua vim.cmd.resize(vim.g.hspsize)")
            end, 10
        )
    end
})

return {
    -- Startup profiling
    {
        'dstein64/vim-startuptime',
        cmd = { "StartupTime" }
    },
}
