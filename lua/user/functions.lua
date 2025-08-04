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

" Resizing split more consistently
" dir is either "vertical" or "horizontal"
" operation is either "+" or "-"
function! ResizeSplit(dir, operation)
    let operation = a:operation
    let resize_command = "resize "
    if a:dir == "vertical"
        let resize_command = "vert " . resize_command
    endif
    let size = a:dir == "vertical" ? "5" : "2"

    " check if the split is the most bottom or the most right
    " if it is, then do the inverse
    let oldw = winnr()
    if a:dir == "vertical"
        silent! exe "normal! \<c-w>l"
    elseif a:dir == "horizontal"
        silent! exe "normal! \<c-w>j"
    endif
    let neww = winnr()
    silent! exe oldw.'wincmd w'
    if oldw == neww
        let operation = operation == "+" ? "-" : "+"
    endif

    " If there is no horizontal split and
    " the move is horizontal, then stop
    if oldw == neww && a:dir == "horizontal"
        let oldw = winnr()
        silent! exe "normal! \<c-w>k"
        let neww = winnr()
        silent! exe oldw.'wincmd w'
        if oldw == neww
            return
        endif
    endif

    execute resize_command . operation . size
endfunction
]])
