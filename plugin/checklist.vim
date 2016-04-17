if exists("g:loaded_checklist")
    finish
endif
let g:loaded_checklist = 1

function! s:hasCheckbox(line)
    if matchstr(a:line, '\[[ x]\]') == ""
        return 0
    else
        return 1
    endif
endfunc

function! s:checklistToggleCheckbox()
    let line = getline('.')
    if s:hasCheckbox(line)
        if matchstr(line, '- \[x\]') == ""
            let line = substitute(line, '\[ \]', '\[x\]', '')
        else
            let line = substitute(line, '\[x\]', '\[ \]', '')
        endif
        call setline('.', line)
    else
        echo "No checkbox here."
    endif
endfunc

command ChecklistToggleCheckbox :call <SID>checklistToggleCheckbox()

function! s:checklistNewLine()
    let curLineNum = line('.')
    let curLine = getline(curLineNum)
    let nextLineNum = curLineNum + 1
    if s:hasCheckbox(curLine)
        " Find checkbox text
        let after = split(curLine, "\]")
        if len(after) == 1 || (len(after) > 1 && after[1] == " ")
            " If current checkbox has no value, clear the line
            " call feedkeys("\<CR>", "n")
            call setline('.', '')
        else
            " Otherwise, create the next checkbox
            call setline(curLineNum + 1, "- [ ] ")
            call cursor(nextLineNum, 7)
        endif
    else
        call feedkeys("\<CR>", "n")
    endif
    return ""
endfunc

exec "inoremap <buffer> <silent> <cr> <C-R>=<SID>checklistNewLine()<cr>"
