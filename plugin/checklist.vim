if exists("g:loaded_checklist")
    finish
endif
let g:loaded_checklist = 1

if !exists('g:checklist_filetypes')
    let g:checklist_filetypes = ['markdown', 'text']
endif

function! s:hasCheckbox(line)
    if matchstr(a:line, '\[[ x]\]') == ""
        return 0
    else
        return 1
    endif
endfunc

function! s:checklistAction(action)
    let currentLine = a:firstline
    while currentLine <= a:lastline
        let line = getline(currentLine)
        if s:hasCheckbox(line)
            if a:action == "toggle"
                call s:checklistToggleCheckbox(currentLine, line)
            elseif a:action == "enable"
                call s:checklistEnableCheckbox(currentLine, line)
            else
                call s:checklistDisableCheckbox(currentLine, line)
            endif
        endif
        let currentLine = currentLine + 1
    endwhile
endfunc

function! s:checklistToggleCheckbox(lineNum, lineText)
    if matchstr(a:lineText, '\[x\]') == ""
        let line = substitute(a:lineText, '\[ \]', '\[x\]', '')
    else
        let line = substitute(a:lineText, '\[x\]', '\[ \]', '')
    endif
    call setline(a:lineNum, line)
endfunc

function! s:checklistEnableCheckbox(lineNum, lineText)
    let line = substitute(a:lineText, '\[ \]', '\[x\]', '')
    call setline(a:lineNum, line)
endfunc

function! s:checklistDisableCheckbox(lineNum, lineText)
    let line = substitute(a:lineText, '\[x\]', '\[ \]', '')
    call setline(a:lineNum, line)
endfunc

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

" command ChecklistToggleCheckbox call <SID>checklistToggleCheckbox()
command -range ChecklistToggleCheckbox <line1>,<line2>call <SID>checklistAction("toggle")
command -range ChecklistEnableCheckbox <line1>,<line2>call <SID>checklistAction("enable")
command -range ChecklistDisableCheckbox <line1>,<line2>call <SID>checklistAction("disable")
exec "autocmd FileType " . join(g:checklist_filetypes, ",") . " inoremap <buffer> <silent> <cr> <C-R>=<SID>checklistNewLine()<cr>"
