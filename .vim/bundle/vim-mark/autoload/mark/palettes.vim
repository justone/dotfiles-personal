" mark/palettes.vim: Additional palettes for mark highlighting.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" Contributors: rockybalboa4
"
" Version:     3.1.0

function! mark#palettes#Extended()
	return [
		\   { 'ctermbg':'Blue',       'ctermfg':'Black', 'guibg':'#A1B7FF', 'guifg':'#001E80' },
		\   { 'ctermbg':'Magenta',    'ctermfg':'Black', 'guibg':'#FFA1C6', 'guifg':'#80005D' },
		\   { 'ctermbg':'Green',      'ctermfg':'Black', 'guibg':'#ACFFA1', 'guifg':'#0F8000' },
		\   { 'ctermbg':'Yellow',     'ctermfg':'Black', 'guibg':'#FFE8A1', 'guifg':'#806000' },
		\   { 'ctermbg':'DarkCyan',   'ctermfg':'Black', 'guibg':'#D2A1FF', 'guifg':'#420080' },
		\   { 'ctermbg':'Cyan',       'ctermfg':'Black', 'guibg':'#A1FEFF', 'guifg':'#007F80' },
		\   { 'ctermbg':'DarkBlue',   'ctermfg':'Black', 'guibg':'#A1DBFF', 'guifg':'#004E80' },
		\   { 'ctermbg':'DarkMagenta','ctermfg':'Black', 'guibg':'#A29CCF', 'guifg':'#120080' },
		\   { 'ctermbg':'DarkRed',    'ctermfg':'Black', 'guibg':'#F5A1FF', 'guifg':'#720080' },
		\   { 'ctermbg':'Brown',      'ctermfg':'Black', 'guibg':'#FFC4A1', 'guifg':'#803000' },
		\   { 'ctermbg':'DarkGreen',  'ctermfg':'Black', 'guibg':'#D0FFA1', 'guifg':'#3F8000' },
		\   { 'ctermbg':'Red',        'ctermfg':'Black', 'guibg':'#F3FFA1', 'guifg':'#6F8000' },
		\   { 'ctermbg':'White',      'ctermfg':'Gray',  'guibg':'#E3E3D2', 'guifg':'#999999' },
		\   { 'ctermbg':'LightGray',  'ctermfg':'White', 'guibg':'#D3D3C3', 'guifg':'#666666' },
		\   { 'ctermbg':'Gray',       'ctermfg':'Black', 'guibg':'#A3A396', 'guifg':'#222222' },
		\   { 'ctermbg':'Black',      'ctermfg':'White', 'guibg':'#53534C', 'guifg':'#DDDDDD' },
		\   { 'ctermbg':'Black',      'ctermfg':'Gray',  'guibg':'#131311', 'guifg':'#AAAAAA' },
		\   { 'ctermbg':'Blue',       'ctermfg':'White', 'guibg':'#0000FF', 'guifg':'#F0F0FF' },
		\   { 'ctermbg':'DarkRed',    'ctermfg':'White', 'guibg':'#FF0000', 'guifg':'#FFFFFF' },
		\   { 'ctermbg':'DarkGreen',  'ctermfg':'White', 'guibg':'#00FF00', 'guifg':'#355F35' },
		\   { 'ctermbg':'DarkYellow', 'ctermfg':'White', 'guibg':'#FFFF00', 'guifg':'#6F6F4C' },
		\]
endfunction

function! mark#palettes#Soft()
	return [
		\   {                                            'guibg':'#d1dbff', 'guifg':'#001250' },
		\   {                                            'guibg':'#ffd1e2', 'guifg':'#500039' },
		\   {                                            'guibg':'#d6ffd1', 'guifg':'#095000' },
		\   {                                            'guibg':'#fff3d1', 'guifg':'#503c00' },
		\   {                                            'guibg':'#e8d1ff', 'guifg':'#280050' },
		\   {                                            'guibg':'#d1feff', 'guifg':'#004e50' },
		\   {                                            'guibg':'#d1edff', 'guifg':'#003050' },
		\   {                                            'guibg':'#d6d1ff', 'guifg':'#0a0050' },
		\   {                                            'guibg':'#f9d1ff', 'guifg':'#460050' },
		\   {                                            'guibg':'#ffe1d1', 'guifg':'#501d00' },
		\   {                                            'guibg':'#e8ffd1', 'guifg':'#265000' },
		\   {                                            'guibg':'#f8ffd1', 'guifg':'#455000' },
		\   {                                            'guibg':'#f8f8f8', 'guifg':'#101010' },
		\   {                                            'guibg':'#f0f0f0', 'guifg':'#202020' },
		\   {                                            'guibg':'#e8e8e8', 'guifg':'#303030' },
		\   {                                            'guibg':'#d8d8d8', 'guifg':'#404040' },
		\   {                                            'guibg':'#c8c8c8', 'guifg':'#505050' },
		\   {                                            'guibg':'#b0b0ff', 'guifg':'#4c4c6f' },
		\   {                                            'guibg':'#ffb0b0', 'guifg':'#5f4141' },
		\   {                                            'guibg':'#b0ffb0', 'guifg':'#415f41' },
		\   {                                            'guibg':'#ffff80', 'guifg':'#4f4f27' },
		\]
endfunction
function! mark#palettes#Softer()
	return [
		\   {                                            'guibg':'#e9edff', 'guifg':'#001250' },
		\   {                                            'guibg':'#ffe9f1', 'guifg':'#500039' },
		\   {                                            'guibg':'#ebffe9', 'guifg':'#095000' },
		\   {                                            'guibg':'#fff9e9', 'guifg':'#503c00' },
		\   {                                            'guibg':'#f4e9ff', 'guifg':'#280050' },
		\   {                                            'guibg':'#e9feff', 'guifg':'#004e50' },
		\   {                                            'guibg':'#e9f6ff', 'guifg':'#003050' },
		\   {                                            'guibg':'#ebe9ff', 'guifg':'#0a0050' },
		\   {                                            'guibg':'#fce9ff', 'guifg':'#460050' },
		\   {                                            'guibg':'#fff0e9', 'guifg':'#501d00' },
		\   {                                            'guibg':'#f4ffe9', 'guifg':'#265000' },
		\   {                                            'guibg':'#fbffe9', 'guifg':'#455000' },
		\   {                                            'guibg':'#f8f8f8', 'guifg':'#101010' },
		\   {                                            'guibg':'#f2f2f2', 'guifg':'#202020' },
		\   {                                            'guibg':'#ececec', 'guifg':'#303030' },
		\   {                                            'guibg':'#e3e3e3', 'guifg':'#404040' },
		\   {                                            'guibg':'#dcdcdc', 'guifg':'#505050' },
		\   {                                            'guibg':'#c8c8ff', 'guifg':'#4c4c6f' },
		\   {                                            'guibg':'#ffc8c8', 'guifg':'#5f4141' },
		\   {                                            'guibg':'#c8ffc8', 'guifg':'#415f41' },
		\   {                                            'guibg':'#ffff98', 'guifg':'#4f4f27' },
		\]
endfunction

function! mark#palettes#Maximum()
		let l:palette = [
		\   { 'ctermbg':'Cyan',       'ctermfg':'Black', 'guibg':'#8CCBEA', 'guifg':'Black' },
		\   { 'ctermbg':'Green',      'ctermfg':'Black', 'guibg':'#A4E57E', 'guifg':'Black' },
		\   { 'ctermbg':'Yellow',     'ctermfg':'Black', 'guibg':'#FFDB72', 'guifg':'Black' },
		\   { 'ctermbg':'Red',        'ctermfg':'Black', 'guibg':'#FF7272', 'guifg':'Black' },
		\   { 'ctermbg':'Magenta',    'ctermfg':'Black', 'guibg':'#FFB3FF', 'guifg':'Black' },
		\   { 'ctermbg':'Blue',       'ctermfg':'Black', 'guibg':'#9999FF', 'guifg':'Black' },
		\]
		if has('gui_running') || &t_Co >= 88
		let l:palette += [
		\   { 'ctermfg':'White',      'ctermbg':'23',    'guifg':'White',   'guibg':'#005f5f' },
		\   { 'ctermfg':'White',      'ctermbg':'27',    'guifg':'White',   'guibg':'#005fff' },
		\   { 'ctermfg':'White',      'ctermbg':'29',    'guifg':'White',   'guibg':'#00875f' },
		\   { 'ctermfg':'White',      'ctermbg':'34',    'guifg':'White',   'guibg':'#00af00' },
		\   { 'ctermfg':'Black',      'ctermbg':'37',    'guifg':'Black',   'guibg':'#00afaf' },
		\   { 'ctermfg':'Black',      'ctermbg':'43',    'guifg':'Black',   'guibg':'#00d7af' },
		\   { 'ctermfg':'Black',      'ctermbg':'47',    'guifg':'Black',   'guibg':'#00ff5f' },
		\   { 'ctermfg':'White',      'ctermbg':'52',    'guifg':'White',   'guibg':'#5f0000' },
		\   { 'ctermfg':'White',      'ctermbg':'53',    'guifg':'White',   'guibg':'#5f005f' },
		\   { 'ctermfg':'White',      'ctermbg':'58',    'guifg':'White',   'guibg':'#5f5f00' },
		\   { 'ctermfg':'White',      'ctermbg':'60',    'guifg':'White',   'guibg':'#5f5f87' },
		\   { 'ctermfg':'White',      'ctermbg':'64',    'guifg':'White',   'guibg':'#5f8700' },
		\   { 'ctermfg':'White',      'ctermbg':'65',    'guifg':'White',   'guibg':'#5f875f' },
		\   { 'ctermfg':'Black',      'ctermbg':'66',    'guifg':'Black',   'guibg':'#5f8787' },
		\   { 'ctermfg':'Black',      'ctermbg':'72',    'guifg':'Black',   'guibg':'#5faf87' },
		\   { 'ctermfg':'Black',      'ctermbg':'74',    'guifg':'Black',   'guibg':'#5fafd7' },
		\   { 'ctermfg':'Black',      'ctermbg':'78',    'guifg':'Black',   'guibg':'#5fd787' },
		\   { 'ctermfg':'Black',      'ctermbg':'79',    'guifg':'Black',   'guibg':'#5fd7af' },
		\   { 'ctermfg':'Black',      'ctermbg':'85',    'guifg':'Black',   'guibg':'#5fffaf' },
		\]
		endif
		if has('gui_running') || &t_Co >= 256
		let l:palette += [
		\   { 'ctermfg':'White',      'ctermbg':'90',    'guifg':'White',   'guibg':'#870087' },
		\   { 'ctermfg':'White',      'ctermbg':'95',    'guifg':'White',   'guibg':'#875f5f' },
		\   { 'ctermfg':'White',      'ctermbg':'96',    'guifg':'White',   'guibg':'#875f87' },
		\   { 'ctermfg':'Black',      'ctermbg':'101',   'guifg':'Black',   'guibg':'#87875f' },
		\   { 'ctermfg':'Black',      'ctermbg':'107',   'guifg':'Black',   'guibg':'#87af5f' },
		\   { 'ctermfg':'Black',      'ctermbg':'114',   'guifg':'Black',   'guibg':'#87d787' },
		\   { 'ctermfg':'Black',      'ctermbg':'117',   'guifg':'Black',   'guibg':'#87d7ff' },
		\   { 'ctermfg':'Black',      'ctermbg':'118',   'guifg':'Black',   'guibg':'#87ff00' },
		\   { 'ctermfg':'Black',      'ctermbg':'122',   'guifg':'Black',   'guibg':'#87ffd7' },
		\   { 'ctermfg':'White',      'ctermbg':'130',   'guifg':'White',   'guibg':'#af5f00' },
		\   { 'ctermfg':'White',      'ctermbg':'131',   'guifg':'White',   'guibg':'#af5f5f' },
		\   { 'ctermfg':'Black',      'ctermbg':'133',   'guifg':'Black',   'guibg':'#af5faf' },
		\   { 'ctermfg':'Black',      'ctermbg':'138',   'guifg':'Black',   'guibg':'#af8787' },
		\   { 'ctermfg':'Black',      'ctermbg':'142',   'guifg':'Black',   'guibg':'#afaf00' },
		\   { 'ctermfg':'Black',      'ctermbg':'152',   'guifg':'Black',   'guibg':'#afd7d7' },
		\   { 'ctermfg':'White',      'ctermbg':'160',   'guifg':'White',   'guibg':'#d70000' },
		\   { 'ctermfg':'Black',      'ctermbg':'166',   'guifg':'Black',   'guibg':'#d75f00' },
		\   { 'ctermfg':'Black',      'ctermbg':'169',   'guifg':'Black',   'guibg':'#d75faf' },
		\   { 'ctermfg':'Black',      'ctermbg':'174',   'guifg':'Black',   'guibg':'#d78787' },
		\   { 'ctermfg':'Black',      'ctermbg':'175',   'guifg':'Black',   'guibg':'#d787af' },
		\   { 'ctermfg':'Black',      'ctermbg':'186',   'guifg':'Black',   'guibg':'#d7d787' },
		\   { 'ctermfg':'Black',      'ctermbg':'190',   'guifg':'Black',   'guibg':'#d7ff00' },
		\   { 'ctermfg':'White',      'ctermbg':'198',   'guifg':'White',   'guibg':'#ff0087' },
		\   { 'ctermfg':'Black',      'ctermbg':'202',   'guifg':'Black',   'guibg':'#ff5f00' },
		\   { 'ctermfg':'Black',      'ctermbg':'204',   'guifg':'Black',   'guibg':'#ff5f87' },
		\   { 'ctermfg':'Black',      'ctermbg':'209',   'guifg':'Black',   'guibg':'#ff875f' },
		\   { 'ctermfg':'Black',      'ctermbg':'212',   'guifg':'Black',   'guibg':'#ff87d7' },
		\   { 'ctermfg':'Black',      'ctermbg':'215',   'guifg':'Black',   'guibg':'#ffaf5f' },
		\   { 'ctermfg':'Black',      'ctermbg':'220',   'guifg':'Black',   'guibg':'#ffd700' },
		\   { 'ctermfg':'Black',      'ctermbg':'224',   'guifg':'Black',   'guibg':'#ffd7d7' },
		\   { 'ctermfg':'Black',      'ctermbg':'228',   'guifg':'Black',   'guibg':'#ffff87' },
		\]
		endif
		if has('gui_running')
		let l:palette += [
		\   {                                            'guifg':'Black',   'guibg':'#b3dcff' },
		\   {                                            'guifg':'Black',   'guibg':'#99cbd6' },
		\   {                                            'guifg':'Black',   'guibg':'#7afff0' },
		\   {                                            'guifg':'Black',   'guibg':'#a6ffd2' },
		\   {                                            'guifg':'Black',   'guibg':'#a2de9e' },
		\   {                                            'guifg':'Black',   'guibg':'#bcff80' },
		\   {                                            'guifg':'Black',   'guibg':'#e7ff8c' },
		\   {                                            'guifg':'Black',   'guibg':'#f2e19d' },
		\   {                                            'guifg':'Black',   'guibg':'#ffcc73' },
		\   {                                            'guifg':'Black',   'guibg':'#f7af83' },
		\   {                                            'guifg':'Black',   'guibg':'#fcb9b1' },
		\   {                                            'guifg':'Black',   'guibg':'#ff8092' },
		\   {                                            'guifg':'Black',   'guibg':'#ff73bb' },
		\   {                                            'guifg':'Black',   'guibg':'#fc97ef' },
		\   {                                            'guifg':'Black',   'guibg':'#c8a3d9' },
		\   {                                            'guifg':'Black',   'guibg':'#ac98eb' },
		\   {                                            'guifg':'Black',   'guibg':'#6a6feb' },
		\   {                                            'guifg':'Black',   'guibg':'#8caeff' },
		\   {                                            'guifg':'Black',   'guibg':'#70b9fa' },
		\]
		endif
	return l:palette
endfunction

" vim: ts=4 sts=0 sw=4 noet
