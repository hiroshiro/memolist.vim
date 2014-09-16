" autoload/memolist.vim
" forked from Akira Maeda <glidenote@gmail.com>
" Author:  Akira Maeda <glidenote@gmail.com> Hiroshi Murata <agend21@icloud.com>
" Version: 0.1.?
" Install this file as autoload/memolist.vim.  This file is sourced manually by
" plugin/memolist.vim.  It is in autoload directory to allow for future usage of
" Vim 7's autoload feature.

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set

if &cp || exists("g:autoloaded_memolist")
  finish
endif
let g:autoloaded_memolist= '1'

let s:cpo_save = &cpo
set cpo&vim

" Utility Functions {{{1
function! s:error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
  let v:errmsg = a:str
endfunction
" }}}1

"------------------------
" setting
"------------------------
if !exists('g:memolist_memo_suffix')
  let g:memolist_memo_suffix = "markdown"
endif

if !exists('g:memolist_memo_date')
  let g:memolist_memo_date = "%Y-%m-%d %H:%M"
endif

if !exists('g:memolist_title_pattern')
  let g:memolist_title_pattern = "[ /\\'\"]"
endif

if !exists('g:memolist_template_dir_path')
  let g:memolist_template_dir_path = ""
endif

if !exists('g:memolist_vimfiler_option')
  let g:memolist_vimfiler_option = "-split -winwidth=50"
endif

if !exists('g:memolist_unite_source')
  let g:memolist_unite_source = "file"
endif

if !exists('g:memolist_unite_option')
  let g:memolist_unite_option = ""
endif

if !exists('g:memolist_memo_directory_allocation')
  let g:memolist_memo_directory_allocation = 0
endif

if !exists('g:memolist_memo_TODO')
  let g:memolist_memo_TODO = 0
endif

if !exists('g:memolist_memo_TODO_directory')
  let g:memolist_memo_TODO_directory = "TODO"
endif

if !exists('g:memolist_memo_directory')
  let g:memolist_memo_directory = {
  \ 'txt':'txt',
  \ 'md':'markdown',
  \ 'markdown':'markdown',
  \}
endif

function! s:extension(file_name)
  return fnamemodify(a:file_name, ":e")
endfunction

function! s:check_extension(file_name)
  return has_key(g:memolist_memo_directory, s:extension(a:file_name))
endfunction

function! s:extension_directory_name(file_name)
  return get(g:memolist_memo_directory, s:extension(a:file_name))
endfunction

function! s:add_default_suffix(file_name, title)
  if stridx(a:title, '.') == -1
    let s:file_name = a:file_name . "." . g:memolist_memo_suffix
  else
    let s:file_name = a:file_name
  endif
  return s:file_name
endfunction

function! s:filename_prefix(title)
  call s:add_default_suffix(strftime("%Y-%m-%d-") . s:esctitle(a:title), a:title)
endfunction

function! s:filename_prefix_none(title)
  call s:add_default_suffix(s:esctitle(a:title), a:title)
endfunction

function! s:esctitle(str)
  let str = a:str
  let str = tolower(str)
  let str = substitute(str, g:memolist_title_pattern, '-', 'g')
  let str = substitute(str, '\(--\)\+', '-', 'g')
  let str = substitute(str, '\(^-\|-$\)', '', 'g')
  return str
endfunction

function! s:escarg(s)
  return escape(substitute(a:s, '\\', '/', 'g'), ' ')
endfunction

let g:memolist_path = expand(g:memolist_path, ':p')
if !isdirectory(g:memolist_path)
  call mkdir(g:memolist_path, 'p')
endif

let s:memolist_memo_TODO_path = expand(g:memolist_path . "/" . g:memolist_memo_TODO_directory, ':p')

function! s:memolist_make(file)
  exe (&l:modified ? "sp" : "e") s:escarg(a:file)
endfunction

function! s:memolist_default_case()
  return g:memolist_memo_directory_allocation == 0 && g:memolist_memo_TODO == 0
endfunction

function! s:memolist_TODO_case()
  return g:memolist_memo_TODO == 1
endfunction

function! s:memolist_extension_case()
  return g:memolist_memo_directory_allocation == 1
endfunction

function! s:memolist_default() abort
  call s:memolist_make(g:memolist_path . "/" . s:file_name)
endfunction

function! s:memolist_TODO(title) abort
  if stridx(a:title, '.') == -1
    if g:memolist_filename_prefix_none == 1|call s:filename_prefix(a:title)|endif
    if !isdirectory(s:memolist_memo_TODO_path)|call mkdir(s:memolist_memo_TODO_path, 'p')|endif
    call s:memolist_make(s:memolist_memo_TODO_path . "/" . s:file_name)
    echo 'use of ' . g:memolist_memo_TODO_directory . ' folder.'
  elseif s:memolist_extension_case() != 1
    call s:memolist_default()
  else
    call s:memolist_extension(a:title)
  endif
endfunction

function! s:memolist_extension(title) abort
  if s:check_extension(s:file_name) == 0 && stridx(a:title, '.') == -1
    call s:memolist_default()
  elseif s:check_extension(s:file_name) == 1
    if !isdirectory(s:memolist_extension_path)|call mkdir(s:memolist_extension_path, 'p')|endif
    call s:memolist_make(s:memolist_extension_path . "/" . s:file_name)
    echo 'use of ' . s:extension_directory_name(s:file_name) . ' folder.'
  else
    call s:memolist_default()
  endif
endfunction

"------------------------
" function
"------------------------
function! memolist#list()
  if get(g:, 'memolist_vimfiler', 0) != 0
    exe "VimFiler" g:memolist_vimfiler_option s:escarg(g:memolist_path)
  elseif get(g:, 'memolist_unite', 0) != 0
    exe "Unite" g:memolist_unite_source.':'.s:escarg(g:memolist_path) g:memolist_unite_option
  else
    exe "e" s:escarg(g:memolist_path)
  endif
endfunction

function! memolist#listTODO()
  if get(g:, 'memolist_vimfiler', 0) != 0
    exe "VimFiler" g:memolist_vimfiler_option s:escarg(s:memolist_memo_TODO_path)
  elseif get(g:, 'memolist_unite', 0) != 0
    exe "Unite" g:memolist_unite_source.':'.s:escarg(s:memolist_memo_TODO_path) g:memolist_unite_option
  else
    exe "e" s:escarg(s:memolist_memo_TODO_path)
  endif
endfunction

function! memolist#grep(word)
  let word = a:word
  if word == ''
    let word = input("MemoGrep word: ")
  endif
  if word == ''
    return
  endif

  try
    if get(g:, 'memolist_qfixgrep', 0) != 0
      exe "Vimgrep -r" s:escarg(word) s:escarg(g:memolist_path . "/*/*")
    else
      exe "vimgrep" s:escarg(word) s:escarg(g:memolist_path . "/*/*")
    endif
  catch
    redraw | echohl ErrorMsg | echo v:exception | echohl None
  endtry
endfunction

function! memolist#_complete_ymdhms(...)
  return [strftime("%Y%m%d%H%M")]
endfunction

function! memolist#new(title)
  let items = {
  \ 'title': a:title,
  \ 'date':  localtime(),
  \ 'tags':  [],
  \ 'categories':  [],
  \}

  if g:memolist_memo_date != 'epoch'
    let items['date'] = strftime(g:memolist_memo_date)
  endif
  if items['title'] == ''
    let items['title']= input("Memo title: ", "", "customlist,memolist#_complete_ymdhms")
  endif
  if items['title'] == ''
    return
  endif

  if get(g:, 'memolist_prompt_tags', 0) != 0
    let items['tags'] = join(split(input("Memo tags: "), '\s'), ' ')
  endif

  if get(g:, 'memolist_prompt_categories', 0) != 0
    let items['categories'] = join(split(input("Memo categories: "), '\s'), ' ')
  endif

  if get(g:, 'memolist_filename_prefix_none', 0) != 0
    call s:filename_prefix_none(items['title'])
  else
    call s:filename_prefix(items['title'])
  endif

  let s:memolist_extension_path = expand(g:memolist_path . "/" . s:extension_directory_name(s:file_name), ":p")

  try
    if s:memolist_default_case()
      call s:memolist_default()
    elseif s:memolist_TODO_case()
      call s:memolist_TODO(items['title'])
    elseif s:memolist_extension_case()
      call s:memolist_extension(items['title'])
    else
      s:error("For some reason can't make this memo.")
    endif
  catch
    redraw | echohl ErrorMsg | echo v:exception | echohl None
  finally
    echo "Making that memo: " . s:file_name
  endtry

  " memo template
  let template = s:default_template
  if g:memolist_template_dir_path != ""
    let path = expand(g:memolist_template_dir_path, ":p")
    let path = path . "/" . g:memolist_memo_suffix . ".txt"
    if filereadable(path)
      let template = readfile(path)
    endif
  endif
  " apply template
  let old_undolevels = &undolevels
  set undolevels=-1
  call append(0, s:apply_template(template, items))
  let &undolevels = old_undolevels
  set nomodified

endfunction

let s:default_template = [
\ 'title: {{_title_}}',
\ '==========',
\ 'date: {{_date_}}',
\ 'tags: [{{_tags_}}]',
\ 'categories: [{{_categories_}}]',
\ '- - -',
\]

function! s:apply_template(template, items)
  let mx = '{{_\(\w\+\)_}}'
  return map(copy(a:template), "
  \  substitute(v:val, mx,
  \   '\\=has_key(a:items, submatch(1)) ? a:items[submatch(1)] : submatch(0)', 'g')
  \")
endfunction

let &cpo = s:cpo_save

" vim:set ft=vim ts=2 sw=2 sts=2:
