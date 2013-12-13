" =============================================================================
" File:           autoload/ctrlp/digraphs.vim
" Description:    Digraphs source for CtrlP
" =============================================================================

" To load this extension into CtrlP, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['digraphs']
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'digraphs',
"         \ 'other_extension',
"         \ 'one_more',
"         \ ]

if (exists('g:loaded_ctrlp_digraphs') && g:loaded_ctrlp_digraphs)
        \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_digraphs = 1

let s:digraph_list = readfile(expand('<sfile>:p:h') . '/digraphs.txt')

if has('multi_byte')
  call extend(s:digraph_list, readfile(expand('<sfile>:p:h') . '/digraphs-multibyte.txt'))
endif

call add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#digraphs#init()',
      \ 'accept': 'ctrlp#digraphs#accept',
      \ 'lname': 'Digraphs (char|digraph|hex|dec|official name)',
      \ 'sname': 'Digraphs',
      \ 'type': 'line',
      \ 'sort': 0,
      \ 'specinput': 0,
      \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#digraphs#init()
  return s:digraph_list
endfunction

function! ctrlp#digraphs#accept(mode, str)
  call ctrlp#exit()
  let cols = split(a:str, '\s*\t\s*0*')
  exec ":normal i" . nr2char(cols[3], cols[3] > 255)
endfunction

function! ctrlp#digraphs#id()
  return s:id
endfunction
