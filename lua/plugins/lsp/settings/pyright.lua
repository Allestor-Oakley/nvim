return {
    on_init = function(client)
        client.config.settings.python.pythonPath = require("plugins.components.python_env")("pyright")
        return true
    end,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                typeCheckingMode = "off",
                reportUnusedVariable = "none",
                reportUnusedClass = "none",
                reportUnusedImport = "none",
                reportUnusedFunction = "none",
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,
                diagnosticMode = 'openFilesOnly',
                ignore = { '*' },
            },
        },
    },
}
