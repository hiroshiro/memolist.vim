# memolist.vim

This is memolist.vim forked from [glidenote/memolist.vim](https://github.com/glidenote/memolist.vim).
There are options that I have added.
Please set the vimrc in any way you want.

## Add Options

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

## Recommended settings

```vim
" remove filename prefix (default 0)
let g:memolist_filename_prefix_none = 1

" use unite (default 0)
let g:memolist_unite = 1

" use arbitrary unite source (default is 'file')
let g:memolist_unite_source = 'file_rec'

" use arbitrary unite option (default is empty)
let g:memolist_unite_option = '-no-start-insert'

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
