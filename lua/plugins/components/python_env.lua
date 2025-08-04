return function(plugin_name)
    local pythonPath = ""
    if vim.fn.exists("g:CondaEnv") == 1 then
        pythonPath = vim.g.CondaPrefixPath .. vim.g.CondaEnv .. "\\python.exe"
    elseif vim.fn.isdirectory("venv") == 1 then
        pythonPath = vim.fn.getcwd() .. "\\venv\\Scripts\\python.exe"
    elseif vim.fn.isdirectory(".venv") == 1 then
        pythonPath = vim.fn.getcwd() .. "\\.venv\\Scripts\\python.exe"
    else
        pythonPath = vim.g.PythonPath
    end
    print(plugin_name .. " use python env: " .. pythonPath)
    return pythonPath
end
