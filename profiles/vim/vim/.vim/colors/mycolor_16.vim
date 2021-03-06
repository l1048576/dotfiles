" Vim color file
" Maintainer;    Larry <include.memory@gmail.com>
" Last Change:  2012 Apr 22
" color scheme for 16color-terminal.
"
" mycolor_16 -- dark background 16color

set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif


let colors_name = "mycolor_16"

"highlight Normal		guifg=#d0d0d0 guibg=#000010						ctermfg=252 ctermbg=16
highlight Normal		guifg=#d0d0d0 guibg=#000010						ctermfg=15
highlight ErrorMsg		guifg=#ffffff guibg=#287eff						ctermfg=15 ctermbg=6
highlight Visual		guifg=#8080ff guibg=fg		gui=reverse				ctermfg=4 ctermbg=fg cterm=reverse
highlight VisualNOS		guifg=#8080ff guibg=fg		gui=reverse,underline	ctermfg=4 ctermbg=fg cterm=reverse,underline
highlight Todo			guifg=#d14a14 guibg=#1248d1						ctermfg=9	ctermbg=14
highlight Search		guifg=#90fff0 guibg=#2050d0						ctermfg=14 ctermbg=6 cterm=underline term=underline
highlight IncSearch		guifg=#b0ffff guibg=#2050d0						ctermfg=15 ctermbg=6

" ZenkakuSpace : 全角スペース (Full width space)
highlight ZenkakuSpace	guibg=#333333									ctermbg=237 cterm=underline
"match ZenkakuSpace /　/
augroup zenkakuSpaceHighlight
	autocmd!
	autocmd Vimenter,WinEnter,BufRead * match ZenkakuSpace /　/
augroup END

" SpecialKey : 不可視文字の一部
highlight SpecialKey	guifg=#666600						ctermfg=4
"highlight Directory		
"highlight Title			
"highlight WarningMsg	
highlight WildMenu		guibg=#c0c0c0						ctermbg=7
"highlight ModeMsg		
"highlight MoreMsg		
"highlight Question		
highlight NonText		guifg=#0000aa						ctermfg=4

"highlight StatusLine	guibg=#ff0000						ctermbg=196
"highlight StatusLineNC	guibg=#ff0000						ctermbg=196
highlight StatusLine	guibg=#D75f00						ctermbg=12
highlight StatusLineNC	guibg=#D75f00						ctermbg=9
"highlight VertSplit	


"highlight Folded		
"highlight FoldColumn	
highlight LineNr		ctermfg=darkyellow
highlight CursorLineNr	term=bold,underline cterm=bold,underline ctermfg=11
highlight CursorLine	term=none cterm=none

"highlight DiffAdd		
"highlight DiffChange	
"highlight DiffDelete	
"highlight DiffText		

"highlight Cursor		
"highlight lCursor		

"highlight Comment		
"highlight Constant		
"highlight Special		
"highlight Identifier	
"highlight Statement	
"highlight PreProc		guifg=#10a0a0						ctermfg=37
"highlight type			
"highlight Underlined	
"highlight Ignore		

highlight Pmenu			guifg=fg guibg=#336600				ctermfg=fg ctermbg=2
highlight PmenuSel		guifg=fg guibg=#0066cc				ctermfg=fg ctermbg=6
"highlight PmenuSbar	
"highlight PmenuThumb	
