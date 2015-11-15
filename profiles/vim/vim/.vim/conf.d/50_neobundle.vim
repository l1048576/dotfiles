""" Bundle

set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	" neobundle#rc() is deprecated.
	"call neobundle#rc(expand('~/.vim/bundle'))
	call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
			\	'build': {
			\		'cygwin': 'make -f make_cygwin.mak',
			\		'unix': 'make -f make_unix.mak',
			\	},
			\ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimfiler'
"" editing
NeoBundle 'osyo-manga/vim-jplus'
" indendLine does 'conceallevel=0'
"NeoBundle 'Yggdroot/indentLine'
NeoBundle 'editorconfig/editorconfig-vim'
"" style
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'gorodinskiy/vim-coloresque'
"" tools
""" ssh
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/unite-ssh'
""" user
NeoBundle 'vim-scripts/sudo.vim'
""" archive
NeoBundle 'vim-scripts/tar.vim'
""" git
NeoBundle 'tpope/vim-fugitive'
""" gpg
NeoBundle 'vim-scripts/gnupg.vim'
""" html/css
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'othree/html5.vim'
NeoBundle 'hokaccha/vim-html5validator'
""" sass
if executable("sass") == 1
	NeoBundle 'AtsushiM/search-parent.vim' " required by sass-compile.vim
	NeoBundle 'AtsushiM/sass-compile.vim'
endif
""" other
"NeoBundle 'mattn/zencoding-vim'
NeoBundle 'vim-scripts/monday'
NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
"NeoBundle 'aharisu/vim_goshrepl.git'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'vim-scripts/The-NERD-Commenter'
NeoBundle 'vim-scripts/The-NERD-tree'
NeoBundle 'vim-scripts/VimCalc'
"NeoBundle 'vim-scripts/VimOutliner'
"NeoBundle 'vim-scripts/vimoutliner-colorscheme-fix'
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'vim-scripts/info.vim'
if executable("ctags") == 1
	NeoBundle 'vim-scripts/taglist.vim'
endif
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'vim-scripts/project.tar.gz'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'vim-scripts/renamer.vim'
"" edit
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'vim-scripts/VOoM'
NeoBundle 'vim-scripts/endwise.vim'
"" filetype
""" binary
NeoBundle 'Shougo/vinarise'
""" (La)tex
"NeoBundle 'vim-scripts/tex.vim'
"NeoBundle 'vim-scripts/LaTeX-Box'
"NeoBundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
"NeoBundle 'vim-scripts/auctex.vim'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
""" haskell
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'indenthaskell.vim'
NeoBundle 'haskell.vim'
NeoBundle 'pbrisbin/vim-syntax-shakespeare'
""" ruby
NeoBundle 'tpope/vim-rails'
""" glsl
NeoBundle 'glsl.vim'
""" toml
NeoBundle 'cespare/vim-toml'
""" reST
"NeoBundle 'Rykka/riv.vim'
"""" (required by riv.vim)
"NeoBundle 'Rykka/clickable.vim'
""" others
" c.vim needs modifying script files...
"NeoBundle 'vim-scripts/c.vim'
"NeoBundle 'vim-scripts/vimwiki'
"NeoBundle 'vim-scripts/brainfuck-syntax'
NeoBundle 'tpope/vim-markdown'
"" colors
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'kana/vim-smartchr'
"" unknown
"NeoBundle 'vim-scripts/neco-look'
" asobi
"" status bar
"NeoBundle 'koron/u-nya-vim'
"" splash
NeoBundle 'thinca/vim-splash'
" non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'

if has('vim_starting')
	call neobundle#end()
endif