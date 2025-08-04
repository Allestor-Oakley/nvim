return {
    on_init = function(client)
        client.config.settings.interpreter = require("plugins.components.python_env")("ruff")
        return true
    end,
}
