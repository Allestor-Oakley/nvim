return {
    UserName = "Allestor Oakley",
    CondaPrefixPath = vim.fn.expand("$HOME/miniconda3/envs/"),
    PythonPath = vim.fn.expand("$HOME/AppData/Local/Programs/Python/Python39/python"),
    LastSessionTracker = vim.fn.stdpath('data') .. "/my-data/last_possession",
    ObsidianWorkspaces = {
        {
            name = "PMO",
            path = "D:/YRP/Z.Lain-lain/PMO/content"
        },
        {
            name = "UNIV",
            path = vim.fn.expand "$HOME/OneDrive/Vault/Univ",
        },
    },
    Size = {
        VerticalSplit = 33,
        HorizontalSplit = 18,
        Float = 0.7
    }
}
