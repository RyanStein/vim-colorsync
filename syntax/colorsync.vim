" Vim syntax file
" Language: rsync itemize-changes logs
" Maintainer: Ryan Stein
" Latest Revision: 2018-04-11

if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'rsync'
endif

" file types
syn match  rsyncTypeFile     'f'  contained nextgroup=rsyncAttrs
syn match  rsyncTypeDir      'd'  contained nextgroup=rsyncAttrs
syn match  rsyncTypeSymlink  'L'  contained nextgroup=rsyncAttrs
syn match  rsyncTypeDevice   'D'  contained nextgroup=rsyncAttrs
syn match  rsyncTypeSpecial  'S'  contained nextgroup=rsyncAttrs

" action types
syn match  rsyncLocal     '^>'   nextgroup=rsyncType.*
syn match  rsyncRemote    '^<'   nextgroup=rsyncType.*
syn match  rsyncChange    '^c'   nextgroup=rsyncType.*
syn match  rsyncHardlink  '^h'   nextgroup=rsyncType.*
syn match  rsyncNoUpdate  '^\.'  nextgroup=rsyncType.*
syn match  rsyncMessage   '^\*.*$'

" attributes
syn match rsyncAttrs '[cstpoguax.+]\{9}' contained contains=rsyncAttrNew,rsyncAttrChange nextgroup=rsyncName
syn match rsyncAttrNew '+*' contained
syn match rsyncAttrChange '[cstpoguax]' contained

" file name
syn match rsyncName '.*$' contained


" default highlights
if version >= 508 || !exists('did_rsync_syn_inits')
	if version < 508
		let did_rsync_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
    endif
    HiLink rsyncLocal        DiffAdd
    HiLink rsyncRemote       DiffAdd
    HiLink rsyncChange       DiffChange
    HiLink rsyncHardlink     DiffAdd
    HiLink rsyncNoUpdate     Normal
    HiLink rsyncMessage      DiffDelete

    HiLink rsyncTypeFile     Normal
    HiLink rsyncTypeDir      Directory
    HiLink rsyncTypeSymlink  Normal
    HiLink rsyncTypeDevice   Normal
    HiLink rsyncTypeSpecial  Normal

    HiLink rsyncAttrs        Normal
    HiLink rsyncAttrNew      DiffAdd
    HiLink rsyncAttrChange   DiffChange

    HiLink rsyncName         Normal

    delcommand HiLink
endif

let b:current_syntax = 'rsync'
