vim.cmd([[
" Trim trailling space
function! StripTrailingWhitespaces()
    let l:ignoreFile = ['md', 'snippets']
    if index(l:ignoreFile, expand('%:e')) < 0
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun

" Hex Editor
function! Hxedit()
    let upper = '         0001 0203 0405 0607 0809 0A0B 0C0D 0E0F'
    let command = "silent! execute '%!xxd' | %y | exe 'norm u' | vne | exe 'norm P' | set ft=xxd | only | exe 'norm ggO\<Esc>'|" . "put =upper"
    exe command
endfunction
]])
