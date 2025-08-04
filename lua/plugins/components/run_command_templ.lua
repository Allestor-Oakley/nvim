return {
    name = "Run g:RunCommand",
    builder = function()
        if vim.fn.exists("g:RunCommand") == 0 then
            return {
                cmd = "gruncommanddoesnotexist",
                name = "g:RunCommand does not exist"
            }
        end
        local function parse_toggleterm_command(runCommand)
            -- a : absolute path, r : relative path, f : filename, e : file extension
            local modifiers = {
                rfe = '%',
                rf  = '%:r',
                fe  = '%:t',
                f   = '%:t:r',
                afe = '%:p',
                af  = '%:p:r',
                e   = '%:e'
            }
            for k, v in pairs(modifiers) do
                local value = string.gsub(vim.fn.expand(v), "\\", "/")
                runCommand = runCommand:gsub("{" .. k .. "}", value)
            end
            return runCommand
        end

        local runCommand = vim.g.RunCommand

        return {
            cmd = parse_toggleterm_command(runCommand),
            name = "run g:RunCommand"
        }
    end,
}
