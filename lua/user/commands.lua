local command = vim.api.nvim_create_user_command

command("Q", ":wa | qa", {})
command("W", ":wa", {})
command("Wa", ":noautocmd wa", {})
command("CD", "cd %:p:h", {})
command("BD", ":%bd|e#", {})
command("E", ":silent !explorer .", {})
command("Hx", ":silent! execute '%!xxd' | %y | exe 'norm u' | vne | exe 'norm P' | set ft=xxd | only", {})
command("SetIndent", function(args)
    local indent_size = args['fargs'][0]
    vim.opt.tabstop = indent_size
    vim.opt.softtabstop = indent_size
    vim.opt.shiftwidth = indent_size
end, { nargs = "*" })
