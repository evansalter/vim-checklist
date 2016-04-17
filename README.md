# vim-checklist

Easly create and manipulate plain-text checklists

![screencast](https://cloud.githubusercontent.com/assets/10549733/14589709/05392082-04a6-11e6-9951-bbe5452750d4.gif)

## Installation

### Vim-Plug

`Plug 'evansalter/vim-checklist'`

You can adapt this to whichever plugin manager you use.

### Usage

#### Creating a Checklist

You can create a checklist using any string for the checkbox, as long as it contains `[ ]` or `[x]`.  For example, to start a GitHub Markdown checklist, type the following in a buffer:

```
- [ ] <OPTION 1 TEXT>
```

When you hit return, a new blank option will be created below:

```
- [ ] <OPTION 1 TEXT>
- [ ] 
```

You can either type the title of the next option, or if the list is complete, hit return again and the checkbox will be deleted.

#### Manipulating Checkboxes

You can toggle, enable, or disable a single checkbox:

1. Put your cursor on a line containing a checkbox
1. Execute one of the following commands, or if you have mappings for the commands (see Configuration), you can use those

```
:ChecklistToggleCheckbox
:ChecklistEnableCheckbox
:ChecklistDisableCheckbox
```

You can also toggle, enable, or disable a range of checkboxes by selecting a range of lines containing checkboxes using visual mode, then executing one of the above commands.


### Configuration

Set up your mappings to toggle, enable, and disable checkboxes.  Add the following lines to your `.vimrc`, 
replacing the mappings with your own:

```viml
nnoremap <leader>ct :ChecklistToggleCheckbox<cr>
nnoremap <leader>ce :ChecklistEnableCheckbox<cr>
nnoremap <leader>cd :ChecklistDisableCheckbox<cr>
vnoremap <leader>ct :ChecklistToggleCheckbox<cr>
vnoremap <leader>ce :ChecklistEnableCheckbox<cr>
vnoremap <leader>cd :ChecklistDisableCheckbox<cr>
```

Ensure to create mappings for normal and visual modes.  This allows you to manipulate either a single checkbox, or a range of checkboxes.

The default filetypes this plugin is enabled for are `text` and `markdown`.  To set your own list of filetypes, add this line to your `.vimrc`:

```viml
let g:checklist_filetypes = ['filetype1', 'filetype2', ...]
```

## Bugs/Requests

Feel free to create an issue if you come across something that doesn't work right, or if it breaks any of your other plugins.  You may also create an issue if you would like to request a new feature for the plugin.
