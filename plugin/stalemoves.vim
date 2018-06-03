if exists("g:stale_loaded")
    finish
endif

" Global Variables {{{
if !exists("g:stalemoves_arrow_type")
    let g:stalemoves_arrow_type = ""
else
    if g:stalemoves_arrow_type !=# "" && g:stalemoves_arrow_type != "g"
        echoerr "g:stalemoves_arrow_type must be set to either blank or 'g'"
        finish
    endif
endif

if !exists("g:stalemoves_commands")
    let g:stalemoves_commands = ['h', 'j', 'k', 'l', 'b', 'e', 'w']
endif

if !exists("g:stalemoves_degrade_start")
    let g:stalemoves_degrade_start = 6
endif

" }}}

let g:stalemoves_loaded = 1

let s:keyCt = 0
let s:atKey = ""

let s:move_arrows = {'j': 1, 'k': 1,}

function! stalemoves#ResetCounter()
    let s:keyCt = 0
    let s:atKey = ""
endfunction

function! stalemoves#IncCounter(key)
    if (a:key != s:atKey)
        call stalemoves#ResetCounter()
        let s:atKey = a:key
        return
    endif

    let s:keyCt += 1
    if s:keyCt >= (g:stalemoves_degrade_start) + 10
        let s:keyCt = 0
        normal! kVjjg??k
        return
    endif
    if s:keyCt >= g:stalemoves_degrade_start
        let l:staleness = s:keyCt - g:stalemoves_degrade_start + 1
        execute "sleep " . (l:staleness * 100) . "m"
        echo "Staleness leve:" . l:staleness
    endif
endfunction

" Iterate through all of the commands to add staleness to
for s:l in g:stalemoves_commands
    let cmd = "nnoremap \<silent> " . s:l . " "  
    " Add optional g movement modification
    if has_key(s:move_arrows, s:l)
        let cmd .= g:stalemoves_arrow_type
    endif
    " Map the command to itself pluss the call to stalemoves#IncCounter
    let cmd .= s:l . ":\<c-u>call stalemoves#IncCounter('" . s:l . "')\<cr>" 
    execute cmd
endfor

augroup stalemoves
    autocmd!
    au TextYankPost * :call stalemoves#ResetCounter()
    au TextChanged * :call stalemoves#ResetCounter()
    au TextChangedI * :call stalemoves#ResetCounter()
augroup END
