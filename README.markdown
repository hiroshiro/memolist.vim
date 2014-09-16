# memolist.vim

This is memolist.vim forked from [glidenote/memolist.vim](https://github.com/glidenote/memolist.vim).
There are options that I have added.
Please set the vimrc in any way you want.

## Add Options
##### g:memolist_memo_directory_allocation
```vim
" It's memolist allocate by filename extension and create a folder automatically. The default is 0.
let g:memolist_memo_directory_allocation = 1

" use directory of memo's allocation. The default setting is 'txt' and 'markdown'.
let g:memolist_memo_directory = {
  \ 'txt':'txt',
  \ 'md':'markdown',
  \ 'markdown':'markdown',
  \}
```
##### g:memolist_memo_TODO
```vim
" This create a folder deficated file of to-do.
" And in that case it will add string to prefix of filename to force.
" TODO is executed unless an extension in the title. default is 0.
let g:memolist_memo_TODO = 1

" Folder name of default is TODO.
" If you want to change folder name of the TODO
" Example:
let g:memolist_memo_TODO_directory = "plan"
```

## Add Commands

Show Memo list of TODO:

```vim
:MemoListTODO
```

## Recommended settings

```vimrc
" remove filename prefix (default 0)
let g:memolist_filename_prefix_none = 1

" use unite (default 0)
let g:memolist_unite = 1

" use arbitrary unite source (default is 'file')
let g:memolist_unite_source = 'file_rec'

" use arbitrary unite option (default is empty)
let g:memolist_unite_option = '-no-start-insert'

let g:memolist_memo_TODO = 1
let g:memolist_memo_directory_allocation = 1
let g:memolist_memo_directory = {
  \ 'txt':'txt',
  \ 'md':'markdown',
  \ 'markdown':'markdown',
  \ 'c':'C',
  \ 'cpp':'Cpp',
  \ 'm':'ObjectiveC',
  \ 'swift':'Swift',
  \ 'coffee':'CoffeeScript',
  \ 'java':'Java',
  \ 'js':'JavaScript',
  \ 'py':'Python',
  \ 'rb':'Ruby',
  \ 'go':'Go',
  \ 'vim':'Vim',
  \ 'html':'HTML',
  \ 'htm':'HTML',
  \ 'php':'PHP',
  \ 'pl':'Perl',
  \ 'css':'CSS',
  \ 'sql':'SQL',
  \ 'sh':'Shell',
  \ 'xml':'XML',
  \ 'yaml':'YAML',
  \}
```
