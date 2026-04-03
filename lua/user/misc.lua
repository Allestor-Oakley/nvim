function Dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

vim.cmd [[
function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
]]

require('vim._core.ui2').enable({
    enable = true,
    msg = {
        targets = {
            [''] = 'msg',
            empty = 'cmd',
            bufwrite = 'msg',
            confirm = 'cmd',
            emsg = 'pager',
            echo = 'msg',
            echomsg = 'msg',
            echoerr = 'pager',
            completion = 'cmd',
            list_cmd = 'pager',
            lua_error = 'pager',
            lua_print = 'msg',
            progress = 'pager',
            rpc_error = 'pager',
            quickfix = 'msg',
            search_cmd = 'cmd',
            search_count = 'cmd',
            shell_cmd = 'pager',
            shell_err = 'pager',
            shell_out = 'pager',
            shell_ret = 'msg',
            undo = 'msg',
            verbose = 'pager',
            wildlist = 'cmd',
            wmsg = 'msg',
            typed_cmd = 'cmd',
        },
        cmd = {
            height = 0.5,
        },
        dialog = {
            height = 0.5,
        },
        msg = {
            height = 0.3,
            timeout = 5000,
        },
        pager = {
            height = 0.5,
        },
    },
})
