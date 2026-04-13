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
	let lvcurr = indent(a:lnum) / shiftwidth() " + 2
	let lvnext = indent(a:lnum+1) / shiftwidth() " + 2
	if lvnext > lvcurr
		return '>' . lvnext
	elseif lvnext < lvcurr
		return '<' . (lvnext+1)
	endif
	return '='
endf

fu! ET(s)
	return substitute(a:s, '\t', repeat(' ', &tabstop), 'g')
endf

fu! FoldText()
	let ln = getline(v:foldstart)
	let marker = ET(matchstr(ln, '^\s*- '))
	let content = substitute(ln, '^\s*- ', '', '')
	let n = v:foldend - v:foldstart
	let ln = marker . content
	return ln . repeat(' ', max([80 - strlen(ln . n), 2])) . n
endf

fu! MyFold()
	setl fdm=expr fde=FE(v:lnum)
	setl fdc=1 fdt=FoldText() fcs+=fold:\ " rm trailing hyphens
endf
au FileType markdown call MyFold()
hi Folded	ctermbg=NONE ctermfg=177
hi FoldColumn	ctermbg=NONE ctermfg=13
