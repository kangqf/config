" -----------------------------------------------------------------------------
" < vimrc 更新日期 2017-06-04 > 
" author: Qingfei Kang
" reference: https://github.com/yangyangwithgnu/use_vim_as_ide
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  < Vim运行环境配置 >
" -----------------------------------------------------------------------------

"  < 判断操作系统是否是 Windows 还是 Linux >
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

"  < 判断是终端还是 Gvim >
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" -----------------------------------------------------------------------------
"  < Vundle配置 >
" -----------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/etc/vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('/etc/vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" 插件放置区
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
Plugin 'majutsushi/tagbar'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'luochen1990/rainbow'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" -----------------------------------------------------------------------------
"  < 系统配置 >
" -----------------------------------------------------------------------------

" autocmd BufWritePost $MYVIMRC source $MYVIMRC " 让配置变更立即生效

let mapleader=";"                " 定义快捷键的前缀，即<Leader>
filetype on                      " 开启文件类型侦测
filetype plugin on               " 根据侦测到的不同类型加载对应的插件
syntax enable                    " 开启语法高亮功能
syntax on                        " 允许用指定语法高亮配色方案替换默认方案
set incsearch                    " 开启实时搜索功能
set hlsearch                     " 高亮搜索
set ignorecase                   " 搜索时大小写不敏感
set nocompatible                 " 关闭兼容模式
set wildmenu                     " vim 自身命令行模式智能补全
set writebackup                  " 保存文件前建立备份，保存成功后删除该备份
set nobackup                     " 设置无备份文件
set gcr=a:block-blinkon0         " 禁止光标闪烁
set autoread                     " 当文件在外部被修改，自动更新该文件
filetype plugin indent on        " 启用缩进
filetype indent on               " 自适应不同语言的智能缩进
set smartindent                  " 启用智能对齐方式
set expandtab                    " 将Tab键转换为空格
set tabstop=4                    " 设置Tab键的宽度
set shiftwidth=4                 " 换行时自动缩进4个空格
set smarttab                     " 指定按一次backspace就删除shiftwidth宽度的空格
set softtabstop=4                " 让 vim  把连续数量的空格视为一个制表符
set nofoldenable                 " 启动时关闭折叠
set foldmethod=syntax            " indent 折叠方式 marker / syntax  / indent
set ruler                        " 显示光标当前位置
set number                       " 显示行号
set laststatus=2                 " 启用状态栏信息高度 原始为二
set cmdheight=2                  " 设置命令行的高度为2，默认为1
set cursorline                   " 突出显示当前行
set cursorcolumn                 " 突出显示当前列
set guifont=courier\ 12          " 设置字体:字号
set nowrap                       " 设置不自动换行
" 字体名称空格用下划线代替 例如: YaHei_Consolas_Hybrid:h10
" 在Linux下设置字体的命令是：: set guifont = courier\ 14
" 而在Windows下则是： : set guifont = Courier:h14
" set foldenable                 " 启动时启用折叠
" set shortmess=atI              " 去掉欢迎界面
" set noswapfile                 " 设置无临时文件
" set vb t_vb=                   " 关闭提示音



" ----------------------------------------------------------------------------------------------
"  < Vim 自身（非插件）快捷键配置 >
" ----------------------------------------------------------------------------------------------

" 定义快捷键到行首和行尾
nmap <Leader>lb 0
nmap <Leader>le $
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>M %

" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y

" -----------------------------------------------------------------------------
"  < 功能配置 > F11 窗口最大化 Ctrl + F11 显示/隐藏菜单栏、工具栏、滚动条
" -----------------------------------------------------------------------------
" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf

map <silent> <F11> :call ToggleFullscreen()<CR> 
autocmd VimEnter * call ToggleFullscreen()      " 启动 vim 时自动全屏

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" -----------------------------------------------------------------------------
"  < 功能配置 > 替换工能设置
" -----------------------------------------------------------------------------
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" -----------------------------------------------------------------------------
"  < 设置代码配色方案>
" -----------------------------------------------------------------------------
" colorscheme Tomorrow-Night-Eighties 233333333
" colorscheme solarized    00000
" colorscheme molokai     00000
" colorscheme phd  		23323
" colorscheme darkburn  00000
" colorscheme desert_terminal 23
" colorscheme Tomorrow-Night-Bright  233333
" colorscheme Tomorrow-Night 00000

if g:isGUI
    colorscheme molokai           "Gvim配色方案
else
    if($TERM == "linux")
    	colorscheme solarized              "tty终端配色方案
    else
	    colorscheme molokai
    endif
endif

" -----------------------------------------------------------------------------
"  < powerline 插件配置 >
" -----------------------------------------------------------------------------
" 状态栏插件，更好的状态栏效果  :PowerlineClearCache清除缓存
let g:Powerline_colorscheme='solarized256'
" let g:Powerline_symbols = 'fancy'

" -----------------------------------------------------------------------------
"  < vim-cpp-enhanced-highlight 插件配置 >
" -----------------------------------------------------------------------------
" 高亮类作用域
let g:cpp_class_scope_highlight = 1
" 高亮成员变量
let g:cpp_member_variable_highlight = 1
" 高亮模板成员函数 对大文件慢
let g:cpp_experimental_simple_template_highlight = 1
" 高亮模板成员函数 对大文件快但是一些情况下不起作用
let g:cpp_experimental_template_highlight = 1
" 高亮库的 concept
let g:cpp_concepts_highlight = 1

" -----------------------------------------------------------------------------
"  < Vim Indent Guides 工具配置 >  <Leader>ig
" -----------------------------------------------------------------------------
"  随 vim  自启动
 let g:indent_guides_enable_on_vim_startup=1
"  从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
"  色块宽度
let g:indent_guides_guide_size=1
"  快捷键 ig  开/ 关缩进可视化
:nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
":nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
" nmap <leader>ig :IndentGuidesToggle<CR>

" -----------------------------------------------------------------------------
"  < vim-fswitch 工具配置 >  <Leader>sw
" -----------------------------------------------------------------------------
" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>


" -----------------------------------------------------------------------------
"  < vim-signature 插件配置 >  书签可视化 mx mda m, ms
" -----------------------------------------------------------------------------

" 自定义 vim-signature 快捷键
let g:SignatureMap = {
	\ 'Leader'             :  "m",
	\ 'PlaceNextMark'      :  "m,",
	\ 'ToggleMarkAtLine'   :  "m.",
	\ 'PurgeMarksAtLine'   :  "m-",
	\ 'DeleteMark'         :  "dm",
	\ 'PurgeMarks'         :  "m<Space>",
	\ 'PurgeMarkers'       :  "m<BS>",
	\ 'GotoNextLineAlpha'  :  "']",
	\ 'GotoPrevLineAlpha'  :  "'[",
	\ 'GotoNextSpotAlpha'  :  "`]",
	\ 'GotoPrevSpotAlpha'  :  "`[",
	\ 'GotoNextLineByPos'  :  "]'",
	\ 'GotoPrevLineByPos'  :  "['",
	\ 'GotoNextSpotByPos'  :  "]`",
	\ 'GotoPrevSpotByPos'  :  "[`",
	\ 'GotoNextMarker'     :  "]-",
	\ 'GotoPrevMarker'     :  "[-",
	\ 'GotoNextMarkerAny'  :  "]=",
	\ 'GotoPrevMarkerAny'  :  "[=",
	\ 'ListBufferMarks'    :  "m/",
	\ 'ListBufferMarkers'  :  "m?"
	\ }

let g:SignaturePurgeConfirmation = 1                "删除所有书签前先确认
let g:SignatureMarkLineHL = "IncSearch"            " 设置独立书签所在行的内容高亮模式组或函数

" 开关显示书签
nnoremap <leader>mt :SignatureToggleSigns<CR>  
" 查看书签列表        
nnoremap <leader>ms :SignatureListBufferMarks 2<CR>
" 更新书签    
nnoremap <leader>mr :SignatureRefresh<CR> 

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >	基于标签的代码导航 
" -----------------------------------------------------------------------------
" ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
" :set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

"----------------------------------------------------------------------------
"  < Tagbar 插件配置 > 
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象
" 常规模式下输入 tb 调用插件
nnoremap <Leader>tb :TagbarToggle<CR> 
let g:tagbar_width=33                      " 设置窗口宽度
" let g:tagbar_left=1                      " 在左侧窗口中显示
let g:tagbar_compact=1                     " tagbar 子窗口中不显示冗余帮助信息
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
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

" -----------------------------------------------------------------------------
"  < indexer 工具配置 >	
" -----------------------------------------------------------------------------
" 调用 ctags 生成标签的神器 
" indexer 生成的标签文件以工程名命名,位于 ~/.indexer_files_tags/
" ~/.indexer_files_tags/ tags就生成在这里，并且以工程名区分
" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

" -----------------------------------------------------------------------------
"  < ctrlsf.vim 插件配置 >
" -----------------------------------------------------------------------------
" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :CtrlSF<CR>

" -----------------------------------------------------------------------------
"  < vim-multiple-cursors 插件配置 >
" -----------------------------------------------------------------------------
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_skip_key='<S-k>'

" -----------------------------------------------------------------------------
"  < UltiSnips 插件配置 >
" -----------------------------------------------------------------------------
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
" let g:UltiSnipsSnippetDirectories=["mysnippets"]

" -----------------------------------------------------------------------------
"  < Ycm 跳转配置 >	基于标签的代码导航 <leader>jd <leader>je
" -----------------------------------------------------------------------------
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>

" -----------------------------------------------------------------------------
"  <  YCM 补全插件配置 > <leader>;
" -----------------------------------------------------------------------------

" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=6 ctermbg=8 guifg=#8B0000 guibg=#ADD8E6 "#EEE8D5
" 选中项
highlight PmenuSel ctermfg=3 ctermbg=4 guifg=#AFD700 guibg=#106900 "#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库 tags
set tags+=/usr/include/c++/5.4.0/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	
"回车即选中当前项
"let g:endwise_no_mappings = 1
" let g:ycm_key_invoke_completion = '<CR>'

" -----------------------------------------------------------------------------
"  "  <  protodef 补全插件配置 >  
"  -----------------------------------------------------------------------------
"  设置 pullproto.pl  脚本路径
let g:protodefprotogetter='/etc/vim/bundle/vim-protodef/pullproto.pl'
"  成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" -----------------------------------------------------------------------------
"  "  <  库信息参考配置 >  <Leader>man
"  -----------------------------------------------------------------------------
"  启用:Man 命令查看各类man 信息
source $VIMRUNTIME/ftplugin/man.vim
"  定义:Man 命令查看各类man 信息的快捷
nmap <Leader>man :Man 3 <cword><CR>

" -----------------------------------------------------------------------------
"  "  < nerdtree 插件配置 > 
"  -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件
" 常规模式下输入 F2 调用插件 即显示文件结构
nmap <F2> :NERDTreeToggle<CR>
"  设置NERDTree 子窗口宽度
let NERDTreeWinSize=32
"  设置NERDTree 子窗口位置
let NERDTreeWinPos="left"
"  显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree  子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
"  删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

"  -----------------------------------------------------------------------------
"   < MiniBufExplorer 插件配置 > <Leader>bl <C-k,j,h,l>切换到上下左右的窗口中去
"  -----------------------------------------------------------------------------
"  快速浏览和操作Buffer"  主要用于同时打开多个文件并相与切换
"用Ctrl加方向键切换到上下左右的窗口中去
let g:miniBufExplMapWindowNavArrows = 1    
"用<C-k,j,h,l>切换到上下左右的窗口中去
" let g:miniBufExplMapWindowNavVim = 1     
"功能增强（不过好像只有在Windows中才有用）   
" let g:miniBufExplMapCTabSwitchBufs = 1      
"<C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
map <C-Tab> :MBEbn<cr>            
 "<C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开
map <C-S-Tab> :MBEbp<cr>                  
"d关闭当前buffer
map  <Leader>d :MBEbd<cr> 			 
" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
"  显示/ 隐藏 MiniBufExplorer  窗口
map <Leader>bl :MBEToggle<cr>

" -----------------------------------------------------------------------------
"  <  恢复快捷键配置 >  <leader>ss  <leader>rs
" -----------------------------------------------------------------------------
"  设置环境保存项
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
"  保存快捷键
map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
"  恢复快捷键
map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>




" -----------------------------------------------------------------------------
"  设置彩虹括号的配置项
" -----------------------------------------------------------------------------
let g:rainbow_active = 1





" -----------------------------------------------------------------------------
"  < 单文件编译、连接、运行配置 > F9 一键保存、编译、连接存并运行
" Ctrl + F9 一键保存并编译 Ctrl + F10 一键保存并连接
" -----------------------------------------------------------------------------
" 以下只做了 C、C++ 的单文件配置，其它语言可以参考以下配置增加

" F9 一键保存、编译、连接存并运行
map <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

"\ -std=c++11 为冷小飞侠添加，为支持C++11
let s:windows_CFlags = 'gcc\ -std=c++11\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -std=c++11\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:windows_CPPFlags = 'g++\ -std=c++11\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -std=c++11\ -g\ -O0\ -c\ %\ -o\ %<.o'

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    endif
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

"以下三句是冷小飞侠添加用于防止vim在控制台乱码的代码
"set fenc=utf-8
"set termencoding=cp936			"控制台输出信息乱码
"language messages zh_cn.utf-8  "控制台菜单乱码
"set fileencodings=cp936,ucs-bom,utf-8
"set encoding=gbk
