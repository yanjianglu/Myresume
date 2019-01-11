let $VIMRUNTIME="/usr/share/vim/vim80"
set runtimepath=/usr/share/vim/vim80
set encoding=utf-8

"Vundle Plugin
set nocompatible
filetype off
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'The-NERD-tree'
Plugin 'taglist.vim'
Plugin 'Auto-Pairs'
Plugin 'L9'
Plugin 'Chiel92/vim-autoformat'
Plugin 'marijnh/tern_for_vim'
Plugin 'https://github.com/wincent/command-t.git'
Plugin 'nathanaelkane/vim-indent-guides.git'
Plugin 'tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-commentary'   "comment
Plugin 'fatih/vim-go'
Plugin 'vim-airline/vim-airline'
Plugin 'Lokaltog/vim-powerline'
Plugin 'w0rp/ale'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'SirVer/ultisnips'
Plugin 'Yggdroot/indentLine'
Plugin 'ianva/vim-youdao-translater'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'wchargin/vim-latexsuite'
Plugin 'rdnetto/YCM-Generator'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'klen/python-mode'


call vundle#end()
filetype plugin indent on



"General Setting

let mapleader=';'
"set nocompatible   " not compatible with the old-fashion vi mode
set bs=2            " allow backspacing over everything in insert mode
set history=1000    " keep 50 lines of command line history
set autoread        " auto read when file is changed from outside
set hlsearch        " search highlighting
set wildmenu        "命令行模式智能补全
set wildmode=longest:full

if has("gui_running")   " GUI color and font settings
	set guifont=Osaka-Mono:h20
	set t_Co=256          " 256 color mode
	set cursorline        " highlight current line
	colors molokai
	highlight CursorLine          guibg=#003853 ctermbg=24
	gui=none cterm=none
	
else
	" terminal color settings
	colors  molokai
endif


syntax enable
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
au BufRead,BufNewFile *.go set filetype=go

"将每行超出80个的字符置为红色
highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
match OverLength /\%81v.\+/


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source %


" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set smartindent
set autoindent      " auto indentation
set incsearch       " incremental search
set ignorecase      " ignorecase search
set nobackup        " no *~ backup files
set copyindent      " copy the previous indentation on autoindenting
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab        " insert tabs on the start of a line according to context
set nu
"set ruler           "显示标尺
set cul             "高亮光标所在行
set shortmess=atI
set showcmd         "显示输入的命令
set scrolloff=2     "光标距离buffer顶部或底部3行
set noswapfile

if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

set cmdheight=1     "命令行行高

set viminfo+=!      " 保存全局变量
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割


" Editing related
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
" set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" TAB setting{
"set expandtab        "replace <TAB> with spaces
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smarttab

au FileType Makefile set noexpandtab
"}
"

"Line setting
set nowrap  "禁止折行
set tw=130  "超过80字符折行
set lbr     "不再单词中间折行
set fo+=mB  "断行模块对亚洲语言的支持


" status line {
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\
set statusline+=[POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容

function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "")
	return curdir
endfunction

function! HasPaste()
	if &paste
		return '[PASTE]'
	else
		return ''
	endif
endfunction

"}


" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^0,:0,bs,g0,h1s,p1,t0,+2,(2,)20,*30

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
	set encoding=utf-8
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun

"去空行
"nnoremap <F4> :g/^\s*$/d<CR>

"去行尾空白符
map <F7> :call DeleteTailSpace()<CR>
func! DeleteTailSpace()
	exec 'w'
	exec '%s/\v^(.{-})\s+$/\1/e'
	exec 'w'
	exec 'e! %'
endfun



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func! SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")
	elseif &filetype == 'python'
		call setline(1,"#!/usr/bin/env python")
		call append(line("."),"# coding=utf-8")
		call append(line(".")+1, "")

	elseif &filetype == 'ruby'
		call setline(1,"#!/usr/bin/env ruby")
		call append(line("."),"# encoding: utf-8")
		call append(line(".")+1, "")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."), "    > File Name: ".expand("%"))
		call append(line(".")+1, "    > Author:Jairo")
		call append(line(".")+2, "    > Mail: yanjianglu2016@gmail.com")
		call append(line(".")+3, "    > Created Time: ".strftime("%c"))
		call append(line(".")+4, " ************************************************************************/")
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include <iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
		call append(line(".")+9, "int main(void)")
		call append(line(".")+10, "{")
		call append(line(".")+11, "")
		call append(line(".")+12, "    return 0;")
		call append(line(".")+13, "}")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include <stdio.h>")
		call append(line(".")+7, "#include <stdlib.h>")
		call append(line(".")+8, "")
		call append(line(".")+9, "int main(int argc, char *argv[])")
		call append(line(".")+10, "{")
		call append(line(".")+11, "")
		call append(line(".")+12, "    return 0;")
		call append(line(".")+13, "}")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
endfunc

"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %< || make"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "! python2.7 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		exec "! go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	elseif &filetype == 'javascript'
		exec "! node %"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc



"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func! FormartSrc()
	exec "w"
	if &filetype == 'c'
		exec "!astyle --style=ansi --suffix=none %"
	elseif &filetype == 'cpp' || &filetype == 'hpp'
		exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
	elseif &filetype == 'perl'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'py'||&filetype == 'python'
		exec "r !autopep8 -i --aggressive %"
	elseif &filetype == 'java'
		exec "!astyle --style=java --suffix=none %"
	elseif &filetype == 'xml'
		exec "!astyle --style=gnu --suffix=none %"
	else
		exec "normal gg=G"
		return
	endif
	exec "e! %"
endfunc


"""""""实用设置

" key shortcuts
" F2    YCM complete hint
" F3    YCM goto declaration
" F4
" F5    Compile and Run
" F6    Format
" F7    Delete Line-Tail space
" F8    Run GDB
" F9    Open or Close NerdTree Window
" F10
" F11
" F12   pastetoggle
" ;     mapleader
inoremap <c-]> <esc>viwUea
inoremap <c-x><c-x> <esc>:wq<cr>
noremap <c-x><c-x> <esc>:q!<cr>

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>] viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>} viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>hbi(<esc>lel


set clipboard+=unnamed  "共享剪贴板
set autowrite           "自动保存
set confirm             "处理未保存和只读文件时确认

set fillchars=vert:\ ,stl:\ ,stlnc:\    "分割窗口之间为空白
set showmatch           " 高亮显示匹配的括号
set matchtime=1         " 匹配括号高亮的时间（单位是十分之一秒）

set foldmethod=syntax   "按语法折叠代码 za zR zM"
set nofoldenable

"记忆退出时光标的位置
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! ManFun(...)
	let cmd = "man "
	if a:0 == 1
		let cmd .= a:1
	elseif a:0 == 2
		let cmd .= a:1 . " " . a:2
	else
		echo "Arg err"
		return
	endif

	let manpage = system(cmd)
	sp __Manpage
	normal! gg
	setlocal filetype=txt
	setlocal buftype=nofile
	call append(0, split(manpage, '\n'))
	setlocal nomodifiable
	normal! gg

endfunction

function! GetCurWord()
	return expand("<cword>")
endfunction

command! -nargs=* Man call ManFun(<f-args>)
nnoremap K <esc>:call ManFun(GetCurWord())<cr>


"------ Plugin vim-indent-guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle"


"------ Plugin tagbar
"autocmd vimenter * Tagbar
noremap <F10> :Tagbar<CR>
inoremap <F10> <esc>:Tagbar<CR>a
let g:tagbar_width=20
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
			\ 'kinds' : [
			\ 'd:macros:1',
			\ 'g:enums',
			\ 't:typedefs:0:0',
			\ 'e:enumerators:0:0',
			\ 'n:namespaces',
			\ 'c:classes',
			\ 's:structs',
			\ 'u:unions',
			\ 'f:functions',
			\ 'm:members:0:0',
			\ 'v:global:0:0',
			\ 'x:external:0:0',
			\ 'l:local:0:0'
			\ ],
			\ 'sro'        : '::',
			\ 'kind2scope' : {
			\ 'g' : 'enum',
			\ 'n' : 'namespace',
			\ 'c' : 'class',
			\ 's' : 'struct',
			\ 'u' : 'union'
			\ },
			\ 'scope2kind' : {
			\ 'enum'      : 'g',
			\ 'namespace' : 'n',
			\ 'class'     : 'c',
			\ 'struct'    : 's',
			\ 'union'     : 'u'
			\ }
			\ }



"------ Plugin ultisnips
"绝对路径
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/bundle/ultisnips/mysnippets/"]
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"



"------ Plugin YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<F2>'
let g:ycm_confirm_extra_conf = 0
"map <F3> :YcmCompleter GoToDeclaration <CR>
map <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_key_list_select_completion = ['','']
"let g:ycm_key_list_previous_completion = ['','']
set completeopt-=preview
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2   
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
let g:ycm_path_to_python_interpreter='/usr/bin/python'

"------ Plugin autoformat
noremap  <F2> :Autoformat<CR>


"------ Plugin NERDTree
let NERDTreeWinSize=25

"列出当前目录文件
map <F9> :NERDTreeToggle<CR>
imap <F9> <ESC> :NERDTreeToggle<CR>

"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set pastetoggle=<F12>



"------ Plugin vim-go settings
let g:go_fmt_command = "goimports"



"------ Plugin youdao-translate
vnoremap <silent> <C-T> :<C-u>Ydv<CR>
nnoremap <silent> <C-T> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"------ Plugin Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth=30
map <silent> <F10> :TlistToggle<cr>

"------Plugin Cscope
noremap cfg : cs find g <c-r><c-w><CR>
noremap cfc : cs find c <c-r><c-w><CR>
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb

	" add any database in current directory"
	if filereadable("cscope.out")
		cs add cscope.out
		"else add database pointed to by environment
		"elseif $CSCOPE_DB != ""
		"   cs add $CSCOPE_DB
	endif
	set csverb
endif


"--------ale
""始终开启标志列
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
""在vim自带的状态栏中整合ale
"let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
""普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
""<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>"



" python-mode {
"
let g:pymode_python = 'python2.7'
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_rope = 0

let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 1
let g:pymode_breakpoint_bind = '<leader>br'


" }



" ----------------indentLine
 let g:indentLine_color_term = 239
 let g:indentLine_char = '¦'
"
" " GVim
 let g:indentLine_color_gui = '#A4E57E'
"
"" none X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

" Background (Vim, GVim)
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
" "



"--------------vim-powerlin
set t_Co=256
let g:Powerline_symbols = 'fancy'
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
highlight LineNr ctermbg=none ctermfg=red
