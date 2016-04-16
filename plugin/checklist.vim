if exists("g:loaded_checklist")
    finish
endif
let g:loaded_checklist = 1

function! s:checklistToggleCheckbox()
    let line = getline('.')
    let match = matchstr(line, '\[[ x]\]')
    if match == ""
        echo "No checkbox here."
    else
        if matchstr(match, 'x') == ""
            let line = substitute(line, '\[ \]', '\[x\]', '')
        else
            let line = substitute(line, '\[x\]', '\[ \]', '')
        endif
        call setline('.', line)
    endif
endfunc

command ChecklistToggleCheckbox :call <SID>checklistToggleCheckbox()
