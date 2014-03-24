"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:	Amir Salihefendic <amix3k at gmail.com>
" Version: 2.8
" Last Change: 20/10/09 14:41:40
"
" Sections:
" ----------------------
"   *> General
"   *> Colors and Fonts
"   *> Fileformats
"   *> VIM userinterface
"   ------ *> Statusline
"   *> Visual
"   *> Moving around and tabs
"   *> General Autocommands
"   *> Parenthesis/bracket expanding
"   *> General Abbrevs
"   *> Editing mappings etc.
"   *> Command-line config
"   *> Buffer realted
"   *> Files and backups
"   *> Folding
"   *> Text options
"   ------ *> Indent
"   *> Spell checking
"   *> Plugin configuration
"   ------ *> Yank ring
"   ------ *> File explorer
"   ------ *> Minibuffer
"   ------ *> Tag list (ctags) - not used
"   ------ *> LaTeX Suite things
"   *> Filetype generic
"   ------ *> Todo
"   ------ *> VIM
"   ------ *> HTML related
"   ------ *> Ruby & PHP section
"   ------ *> Python section
"   ------ *> Cheetah section
"   ------ *> Vim section
"   ------ *> Java section
"   ------ *> JavaScript section
"   ------ *> C mappings
"   ------ *> SML
"   ------ *> Scheme bindings
"   *> Snippets
"   ------ *> Python
"   ------ *> javaScript
"   *> Cope
"   *> MISC
"
"  Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"  Example:
"   Go into command-line mode and type helpgrep nocompatible, ie.
"   :helpgrep nocompatible
"   then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MySys()
	if has("win32")
		return "windows"
	else
		return "linux"
	endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM har to remember
set history=300

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
"set autoread

"Have the mouse enabled all the time:
set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

"Set font to Monaco 10pt
if MySys() == "mac"
  set shell=/bin/bash
elseif MySys() == "windows"
elseif MySys() == "linux"
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T " disable the toolbar
  set background=dark
  let psc_style='cool'
  colorscheme peaksea
  set nu
  set guifont=Ubuntu\ Mono\ 12
else
  colorscheme zellner
  set nu
  set background=dark
  colorscheme oceandeep
endif

set encoding=utf8

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"map <leader>1 :set syntax=cheetah<cr>
"map <leader>2 :set syntax=xhtml<cr>
"map <leader>3 :set syntax=python<cr>
"map <leader>4 :set ft=javascript<cr>
"map <leader>$ :syntax sync fromstart<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=3

"Do not redraw, when running macros.. lazyredraw
set lazyredraw

"Change buffer - without saving
set hidden

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

  """"""""""""""""""""""""""""""
  " => Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
"Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $e ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab cancle cancel
iab Cancle Cancel



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
map <c-q> :sb 

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

" Buffer - reverse everything ... :)
map <F9> ggVGg?

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>

set smarttab
set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " => Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   "set cindent

   "Wrap lines
   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " => Vim Grep
   """"""""""""""""""""""""""""""
   let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
   set grepprg=/bin/grep\ -nH

   """"""""""""""""""""""""""""""
   " => Yank Ring
   """"""""""""""""""""""""""""""
   map <leader>y :YRShow<cr>
   let g:yankring_persist = 0

   """"""""""""""""""""""""""""""
   " => File explorer
   """"""""""""""""""""""""""""""
   "Split vertically

   "Window size
   let g:netrw_winsize=35

   "Hide some files
   let g:netrw_list_hide='^\.DS_Store$,^\.svn/$,^\.settings/$,.*\.pyo$,.*\.pyc,.*\.obj'
   let g:netrw_browse_split=4

   """"""""""""""""""""""""""""""
   " => Minibuffer
   """"""""""""""""""""""""""""""
   let g:miniBufExplModSelTarget = 1
   let g:miniBufExplorerMoreThanOne = 2
   let g:miniBufExplModSelTarget = 0
   let g:miniBufExplUseSingleClick = 1
   let g:miniBufExplMapWindowNavVim = 1
   let g:miniBufExplVSplit = 25
   let g:miniBufExplSplitBelow=1

   let g:bufExplorerSortBy = "name"

   autocmd BufRead,BufNew :call UMiniBufExplorer
   
   map <leader>u :TMiniBufExplorer<cr>:TMiniBufExplorer<cr>


   """"""""""""""""""""""""""""""
   " => Tag list (ctags) - not used
   """"""""""""""""""""""""""""""
   let Tlist_Ctags_Cmd = "/usr/bin/ctags"
   let Tlist_WinWidth = 50
   let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
   let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
   " let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
   let Tlist_Auto_Open = 1

   map <F5> :TlistToggle<cr>
   map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " cscope setting
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   if has("cscope")
       set csprg=/usr/bin/cscope
       set csto=1
       set cst
       set nocsverb
       " add any database in current directory
       if filereadable("cscope.out")
           cs add cscope.out
       endif
       set csverb
   endif

   nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
   nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
   nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
   nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
   nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
   nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
   nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


   """"""""""""""""""""""""""""""
   " => LaTeX Suite things
   """"""""""""""""""""""""""""""
   let g:Tex_DefaultTargetFormat="pdf"
   let g:Tex_ViewRule_pdf='xpdf'

   "Bindings
   autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

   "Auto complete some things ;)
   autocmd FileType tex inoremap $i \indent 
   autocmd FileType tex inoremap $* \cdot 
   autocmd FileType tex inoremap $i \item 
   autocmd FileType tex inoremap $m \[<cr>\]<esc>O


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " => Set Omni complete functions
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   autocmd FileType css set omnifunc=csscomplete#CompleteCSS

   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " => Todo
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim
   au BufNewFile,BufRead *.mako set ft=mako

   """"""""""""""""""""""""""""""
   " => VIM
   """"""""""""""""""""""""""""""
   autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>
   

   """"""""""""""""""""""""""""""
   " => HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1


   """"""""""""""""""""""""""""""
   " => Ruby & PHP section
   """"""""""""""""""""""""""""""
   autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
   autocmd FileType php compiler php
   autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>


   """"""""""""""""""""""""""""""
   " => Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
   "au FileType python so ~/vim_local/syntax/python.vim

   "Python iMaps
   au FileType python set nocindent
   au FileType python inoremap <buffer> $r return 
   au FileType python inoremap <buffer> $i import 
   au FileType python inoremap <buffer> $p print 
   au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi

   au BufNewFile,BufRead *.jinja set syntax=htmljinja
   syn keyword pythonConstant True None False self

   au FileType python map <leader>C ?class 
   au FileType python map <leader>D ?def 


   """"""""""""""""""""""""""""""
   " => Cheetah section
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah set ft=xml
   autocmd FileType cheetah set syntax=cheetah

   """""""""""""""""""""""""""""""
   " => Vim section
   """""""""""""""""""""""""""""""
   autocmd FileType vim set nofen

   """"""""""""""""""""""""""""""
   " => JavaScript section
   """""""""""""""""""""""""""""""
   au FileType javascript so ~/vim_local/syntax/javascript.vim
   function! JavaScriptFold() 
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType javascript call JavaScriptFold()
   au FileType javascript setl fen

   au FileType javascript imap <c-t> AJS.log();<esc>hi
   au FileType javascript imap <c-a> alert();<esc>hi
   au FileType javascript setl nocindent
   au FileType javascript inoremap <buffer> $r return 

   au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi


   """"""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   au FileType html,cheetah set ft=xml
   au FileType html,cheetah set syntax=html


   """"""""""""""""""""""""""""""
   " => C mappings
   """""""""""""""""""""""""""""""
   autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>



   " => Scheme bidings
   """"""""""""""""""""""""""""""
   autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
   autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
   autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Cope
map <silent> <leader><cr> :noh<cr>

"Orginal for all
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
"   *> Link
"   => Anchor
function! SmartTOHtml()
   TOhtml
   try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
   catch
   endtry
   exe ":write!"
   exe ":bd"
endfunction

function! DateToUTC()
    %s/setDate/setUTCDate/g
    %s/setMonth/setUTCMonth/g
    %s/setFullYear/setUTCFullYear/g
    %s/setHours/setUTCHours/g
    %s/setMinute/setUTCMinute/g
    %s/setSecond/setUTCSecond/g

    %s/getDate/getUTCDate/g
    %s/getMonth/getUTCMonth/g
    %s/getFullYear/getUTCFullYear/g
    %s/getHours/getUTCHours/g
    %s/getMinute/getUTCMinute/g
    %s/getSecond/getUTCSecond/g
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guitablabel=%N\ %m\ %t

"map ` $
"imap ` $
"vmap ` $
"cmap ` $

if has("gui_running")
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen
endif

function! Kees_settabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet ts=4 sw=4
    endif
endfunction
autocmd BufReadPost * call Kees_settabs()

" =============================
" for walle
let JavaBrowser_Ctags_Cmd = 'ctags'
let JavaBkrowser_Use_Icon = 1
"let Java

