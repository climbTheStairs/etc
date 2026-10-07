fu! FE(lnum)
"	let ln = getline(a:lnum)
"	if ln =~ '^\s*- '
		return FoldIndentInclPar(a:lnum)
"	elseif ln[0:2] == '## '
"		return '>1'
"	elseif ln[0:3] == '### '
"		return '>2'
"	endif
"	return '='
endf

fu! FoldIndentInclPar(lnum)
	let lvcurr = indent(a:lnum)   / shiftwidth() " + 2
	let lvnext = indent(a:lnum+1) / shiftwidth() " + 2
	if lvnext > lvcurr
		return '>' . lvnext
	elseif lvnext < lvcurr
		return '<' . (lvnext+1)
	endif
	return '='
endf

fu! ExpandTab(s)
	return substitute(a:s, '\t', repeat(' ', &tabstop), 'g')
endf

fu! FoldText()
	let ln = getline(v:foldstart)
	let match_marker = '\v^\s*(- |[0-9]+[.] ?)' "TODO: this is curr imperf
	let marker = ExpandTab(matchstr(ln, match_marker))
	let content = substitute(ln, match_marker, '', '')
	let ln = marker . content
	let n = v:foldend - v:foldstart
	return ln . repeat(' ', max([80 - strdisplaywidth(ln . n), 2])) . n
endf

fu! MyFold()
	setl fdm=expr fde=FE(v:lnum)
	setl fdc=1 fdt=FoldText() fcs+=fold:\ " rm trailing hyphens
endf
au FileType markdown call MyFold()
hi Folded	ctermbg=NONE ctermfg=177
hi FoldColumn	ctermbg=NONE ctermfg=13
