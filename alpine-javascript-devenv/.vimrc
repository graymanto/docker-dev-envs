let mapleader = ","
inoremap jj <Esc>
imap <C-j> <Right><Plug>snipMateNextOrTrigger
nmap <C-tab> :bnext<cr>
nmap <C-S-tab> :bprevious<cr>
" nmap <leader>sc :SyntasticCheck<CR>
nmap <leader>lc :lclose<CR>
nmap <leader>noh :noh<CR>
nmap <C-1> :w<cr>
nnoremap <leader>qq :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>ee :Bclose<CR>
nnoremap <leader>ra :bufdo e!<CR>

noremap <leader>mm :make<CR>
noremap <leader>co :Copen<CR>
noremap <leader>sm :messages<CR>

nnoremap <leader>zw :ZoomWin<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>grr :!git co %<cr>
nnoremap <leader>ccl :ccl<cr>
nnoremap <leader>lia :cl<cr>

nnoremap <leader>su :execute 'sign unplace * buffer=' . bufnr('')<CR>

nnoremap <leader>cpps :vsplit ~/.vim/bundle/vim-snippets/snippets/cpp.snippets<cr>
nnoremap <leader>cards :vsplit ~/.vim/bundle/vim-snippets/snippets/arduino.snippets<cr>

""""""""""" Complimentary settings bindings """""""""""""""

nnoremap [et :set expandtab<cr>
nnoremap ]et :set noexpandtab<cr>
nnoremap [pt :set paste<cr>
nnoremap ]pt :set nopaste<cr>

""""""""""" Terminal fixes """""""""""""""
"fix meta-keys which generate <Esc>a .. <Esc>z

if !has('gui_running')
	let c='a'
	while c <= 'z'
		exec "set <M-".toupper(c).">=\e".c
		exec "imap \e".c." <M-".toupper(c).">"
		let c = nr2char(1+char2nr(c))
	endw
else
	let s:screen  = &term =~ 'screen'
	let s:tmux = &term =~ 'tmux'
	let s:xterm   = &term =~ 'xterm'

	" make use of Xterm "bracketed paste mode"
	" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
	" http://stackoverflow.com/questions/5585129
	if s:screen || s:xterm || s:tmux
		function! s:BeginXTermPaste(ret)
			set pastetoggle=<f29>
			set paste
			return a:ret
		endfunction

		" enable bracketed paste mode on entering Vim
		let &t_ti .= "\e[?2004h"

		" disable bracketed paste mode on leaving Vim
		let &t_te = "\e[?2004l" . &t_te

		let &t_SI .= "\<Esc>[?2004h"
		let &t_EI .= "\<Esc>[?2004l"

		set pastetoggle=<Esc>[201~

		inoremap <special> <expr> <Esc>[200~ BeginXTermPaste("")
		inoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("")
		nnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("i")
		vnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("c")
		cnoremap <Esc>[200~ <nop>
		cnoremap <Esc>[201~ <nop>

		execute "set <f28>=\<Esc>[200~"
		execute "set <f29>=\<Esc>[201~"
		map <expr> <f28> XTermPasteBegin("i")
		imap <expr> <f28> XTermPasteBegin("")
		vmap <expr> <f28> XTermPasteBegin("c")
		cmap <f28> <nop>
		cmap <f29> <nop>
	endif
endif

""""""""""" Resize  mode """""""""""""""

nnoremap <M-Right> :vertical resize +5<CR>
nnoremap <M-Left>  :vertical resize -5<CR>
nnoremap <M-Up>    :resize -5<CR>
nnoremap <M-Down>  :resize +5<CR>

if has("gui_macvim")
	set fuoptions=maxvert,maxhorz
	set noballooneval

	" Automatically resize splits
	" when resizing MacVim window
	autocmd VimResized * wincmd =
else
	" For terminal
	nnoremap [1;3C     :vertical resize +5<CR>
	nnoremap [1;3D     :vertical resize -5<CR>
	nnoremap [1;3A     :resize -5<CR>
	nnoremap [1;3B     :resize +5<CR>
endif

if has("macunix")
	nnoremap <space><Right> :vertical resize +5<CR>
	nnoremap <space><Left>  :vertical resize -5<CR>
	nnoremap <space><Up>    :resize -5<CR>
	nnoremap <space><Down>  :resize +5<CR>
endif

""""""""""""""""""""""""""""""""""""""""

" silent! :unmap <leader>b
noremap <leader>bw :bw<CR>
noremap <leader>bc :BClose<CR>

vnoremap . :norm.<CR>

" upper/lower word
nmap <leader>uc mQviwU`Q
nmap <leader>lc mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<cr>:set wrap?<cr>

" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

set shiftwidth=4

""""""""""" Commands """"""""""""""

" Some just for shell command examples. Can be done better if that was the
" idea
command! -range StripLastChar <line1>,<line2>!rev | cut -c 2- | rev
command! -range -nargs=1 StripLastChars <line1>,<line2>!rev | cut -c <f-args>- | rev
command! -range -nargs=1 StripFirstChars <line1>,<line2>!cut -c <f-args>-
command! -range TrimFront <line1>,<line2>!sed 's/^[ 	]*//g'
command! Spacify :.s/\t/    /g
command! SpacifyAll :%!expand -t4
command! TabifyAll :%!unexpand -t4
command! -range AddNumbers :<line1>,<line2>!nl | sed 's/ *//g'

"""""""""""""""""""""""""""""""""""

" System clipboard
vmap <space>y "+y
nmap <space>y "+yy
nmap <Leader>yy "+yy
nmap <Leader>pp "+p
nmap <space>p "+p

:iabbrev waht what
:iabbrev tehn then


set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set tabstop=4

colorscheme desert

set dir-=.
" set backupdir-=.
" set directory-=.

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files

set hidden

set list                      " Show invisible characters
func! ListCharsCommon()
	set listchars+=trail:.            " show trailing spaces as dots
	set listchars+=extends:>          " The character to show in the last column when wrap is
	" off and the line continues beyond the right of the screen
	set listchars+=precedes:<         " The character to show in the last column when wrap is
	" off and the line continues beyond the left of the scree
	"
endfunc

func! ListCharsShowTabs()
	" List chars
	set listchars=""                  " Reset the listchars
	" set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
	set listchars=tab:-.             " a tab should display as "  ", trailing whitespace as "."

	call ListCharsCommon()
endfunc
func! ListCharsHideTabs()
	" List chars
	set listchars=""                  " Reset the listchars
	set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."

	call ListCharsCommon()
endfunc
command! ShowTabs :call ListCharsShowTabs()
command! HideTabs :call ListCharsHideTabs()

HideTabs

set nowrap
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault
set number
set showmatch

" set autochdir
set autowriteall
set autowrite

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""" Save session settings """""""""""""

let g:session_autosave = 'no'
let g:session_autoload = 'no'

"""""""""""" Tag settings """""""""""""
set csprg=gtags-cscope
" cscope add /foo/bar/GTAGS

"""""""""""" Vimdiff merge settings """""""""""""

noremap <leader>dgl :diffget LO<CR>
noremap <leader>dgb :diffget BA<CR>
noremap <leader>dgr :diffget RE<CR>

if &diff
	" diff mode only ignore whitespace in comparisons
	set diffopt+=iwhite
endif

"""""""""""" Grep settings """""""""""""

set grepprg=ag\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

"""""""""""" You Complete Me options """""""""""""

let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

nnoremap <leader>gto :YcmCompleter GoTo<CR>
nnoremap <leader>gti :YcmCompleter GoToImprecise<CR>
nnoremap <F12> :YcmCompleter GoToImprecise<CR>

""""""""""" Tabularize """""""""""""""

vnoremap <leader>ta :Tabularize assignment<CR>

""""""""""" Unite """""""""""""""
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_async_command=['ag', '--follow',
			\ '--nogroup', '--nocolor', '--hidden', '--path-to-ignore', '~/.agignore', '-g', '']

nnoremap <space>u :silent up \| :Unite -start-insert file_rec/async<cr>
nnoremap <space>i :Unite -start-insert file_rec/git<cr>
nnoremap <leader>uunc :Unite -quick-match change<cr>
nnoremap <space>c :Unite -quick-match change<cr>
nnoremap <leader>u/ :silent up \| :Unite grep:.<cr>
nnoremap <leader>ur :UniteResume<cr>
nnoremap <leader>un :UniteNext<cr>
nnoremap <leader>un :UnitePrevious<cr>
nnoremap <leader>bb :Unite -quick-match buffer<cr>
nnoremap <leader>uf :Unite function<cr>
" nnoremap <space>y :Unite -quick-match history/yank<cr>
nnoremap <space>f :silent up \| :Unite -start-insert buffer<cr>

nnoremap <leader>gg :execute 'Unite gtags/def'<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>ge :execute 'Unite gtags/grep'<CR>
vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>
nnoremap <space>* :execute "Unite grep:.::<C-R><C-W>:"<CR>

nnoremap <leader>uo :Unite outline<CR>

" Can filter if required ie :Unite -input=foo file

nnoremap <leader>of :<C-u>Unite -start-insert file/async<CR>

if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

""""""""""" Easy motion """""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <space>s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

map  <space>/ <Plug>(easymotion-sn)
omap <space>/ <Plug>(easymotion-tn)
nmap <space>w <Plug>(easymotion-w)
nmap <space>b <Plug>(easymotion-b)

" JK motions: Line motions
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>l <Plug>(easymotion-lineforward)
map <space>h <Plug>(easymotion-linebackward)

""""""""""" Region Expanding """""""""""""""

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

""""""""""" ALE settings """"""""""""""""""""""

let g:ale_cpp_clang_options = "-std=c++14 -Wno-c++11-extensions -Wall -I./include"
let g:ale_cpp_clangtidy_checks = ['-*',
			\ 'performance-*',
			\ 'modernize-*',
			\ 'portability-*',
			\ 'readability-*',
			\ 'cert-*',
			\ 'misc-*',
			\ 'bugprone-*',
			\ 'clang-analyzer-*']
" \ 'cppcoreguidelines-*',
" \ 'hicpp-*',
let g:ale_c_clangtidy_checks = ['-*',
			\ 'performance-*',
			\ 'clang-analyzer-*']
" \ 'hicpp-*',

" \	"cpp": ["clang", "clang-format", "clangtidy", "cppcheck"],

let g:ale_linters = {
			\	"javascript": ["eslint"],
			\	"cpp": ["clang-format", "clangtidy"],
			\	"c": ["clang", "clang-format", "clangtidy", "cppcheck"],
			\}

let g:ale_fixers = {
			\   'c': ['clang-format'],
			\   'cpp': ['clang-format'],
			\   'javascript': ['eslint'],
			\}

let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%] %code%'

""""""""""" Zsh settings """"""""""""""""""""""

augroup zshag
	autocmd!
	autocmd FileType zsh set shiftwidth=4 tabstop=4
augroup END

""""""""""" Vimfile settings """"""""""""""""""""""

augroup vimag
	autocmd!
	autocmd FileType vim set shiftwidth=4 tabstop=4 noexpandtab
augroup END

""""""""""" Javascript settings """""""""""""""

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio'],
    \ }

" \ 'javascript': ['javascript-typescript-stdio'],
" \ 'javascript.jsx': ['javascript-typescript-stdio'],
"
augroup javascriptag
	autocmd!
	func! FormatJs()
		let l:winview = winsaveview()
		:exe '%!npx -q prettier --parser babylon --trailing-comma es5'
		call winrestview(l:winview)
	endfunc

	func! FormatJsNoSemis()
		let l:winview = winsaveview()
		:exe '%!npx -q prettier --parser babylon --trailing-comma es5 --no-semi'
		call winrestview(l:winview)
	endfunc

	func! FormatJsSnippetNoSemis()
		silent exe "'<,'>!npx -q prettier --parser babylon --trailing-comma es5 --no-semi"
	endfunc

	func! FormatJsBeutSnippetNoSemis()
		silent exe "'<,'>!js-beautify --indent-size 2 --jslint-happy --wrap-line-length 120"
		silent exe '%s/;//e'
	endfunc

	:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
	let g:jsx_ext_required = 0
	autocmd FileType javascript nnoremap <leader>gto :YcmCompleter GoToDefinition<CR>
	autocmd FileType javascript nnoremap <leader>gtr :YcmCompleter GoToReferences<<CR>
	autocmd FileType javascript nnoremap <space>r :YcmCompleter GoToReferences<CR>
	autocmd FileType javascript nnoremap <leader>tr :YcmCompleter RefactorRename<CR>
	autocmd FileType javascript nnoremap <leader>tt :YcmCompleter GetType<CR>
	autocmd FileType javascript nnoremap <leader>tdd :YcmCompleter GetDoc<CR>
	autocmd FileType javascript nnoremap <leader>fi :YcmCompleter FixIt<CR>
	autocmd FileType javascript nnoremap <leader>oi :YcmCompleter OrganizeImports<CR>
	autocmd FileType javascript nnoremap <leader>ycmr :YcmCompleter RestartServer<CR>
	autocmd FileType javascript set shiftwidth=2 tabstop=2 expandtab


	au FileType javascript nnoremap <leader>jsr :silent exe '%s/;//'<CR>
	au FileType javascript nnoremap <leader>fff :call FormatJs()<CR>
	au FileType javascript.jsx nnoremap <leader>fff :call FormatJs()<CR>
	au FileType javascript nnoremap <leader>ffn :call FormatJsNoSemis()<CR>
	au FileType javascript vnoremap <leader>fff :!yarn prettier --trailing-comma es5<CR>
	au FileType javascript vnoremap <leader>ffn :call FormatJsSnippetNoSemis()<CR>
	au FileType javascript vnoremap <leader>jsb :call FormatJsBeutSnippetNoSemis()<CR>
	let g:flow#enable = 0
	let g:flow#omnifunc = 1
	let g:flow#timeout = 15
augroup END

""""""""""" Json formatting """""""""""""""

augroup jsontag
	autocmd!

	func! FormatJson()
		let l:winview = winsaveview()
		:exe '%!jq ''.'''
		call winrestview(l:winview)
	endfunc

	au FileType json nnoremap <leader>fff :call FormatJson()<CR>
augroup END

""""""""""" XML settings """""""""""""""

augroup xmlag
	autocmd FileType xml set shiftwidth=4 tabstop=4 expandtab
augroup END

""""""""""" Html settings """"""""""""""""""""""

nnoremap <leader>fht :%!pandoc -f html -t markdown \| pandoc -f markdown -t html<CR>
vnoremap <leader>fht :!pandoc -f html -t markdown \| pandoc -f markdown -t html<CR>

""""""""""" Binary settings """"""""""""""""""""""

" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
func! ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft=&ft
		let b:oldbin=&bin
		" set new options
		setlocal binary " make sure it overrides any textwidth, etc.
		silent :e " this will reload the file without trickeries 
		"(DOS line endings will be shown entirely )
		let &ft="xxd"
		" set status
		let b:editHex=1
		" switch to hex editor
		%!xxd
	else
		" restore old options
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		" set status
		let b:editHex=0
		" return to normal editing
		%!xxd -r
	endif
	" restore values for modified and read only state
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
	" vim -b : edit binary using xxd-format!
	augroup Binary
		au!

		" set binary option for all binary files before reading them
		au BufReadPre *.bin,*.hex setlocal binary

		" if on a fresh read the buffer variable is already set, it's wrong
		au BufReadPost *
					\ if exists('b:editHex') && b:editHex |
					\   let b:editHex = 0 |
					\ endif

		" convert to hex on startup for binary files automatically
		au BufReadPost *
					\ if &binary | Hexmode | endif

		" When the text is freed, the next time the buffer is made active it will
		" re-read the text and thus not match the correct mode, we will need to
		" convert it again if the buffer is again loaded.
		au BufUnload *
					\ if getbufvar(expand("<afile>"), 'editHex') == 1 |
					\   call setbufvar(expand("<afile>"), 'editHex', 0) |
					\ endif

		" before writing a file when editing in hex mode, convert back to non-hex
		au BufWritePre *
					\ if exists("b:editHex") && b:editHex && &binary |
					\  let oldro=&ro | let &ro=0 |
					\  let oldma=&ma | let &ma=1 |
					\  silent exe "%!xxd -r" |
					\  let &ma=oldma | let &ro=oldro |
					\  unlet oldma | unlet oldro |
					\ endif

		" after writing a binary file, if we're in hex mode, restore hex mode
		au BufWritePost *
					\ if exists("b:editHex") && b:editHex && &binary |
					\  let oldro=&ro | let &ro=0 |
					\  let oldma=&ma | let &ma=1 |
					\  silent exe "%!xxd" |
					\  exe "set nomod" |
					\  let &ma=oldma | let &ro=oldro |
					\  unlet oldma | unlet oldro |
					\ endif
	augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'https://github.com/tpope/vim-unimpaired.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'https://github.com/tpope/vim-ragtag.git'
Plugin 'https://github.com/tpope/vim-sensible.git'
Plugin 'https://github.com/tpope/vim-repeat.git'
Plugin 'https://github.com/tpope/vim-dispatch.git'
Plugin 'https://github.com/tpope/vim-rsi.git'
Plugin 'https://github.com/tpope/vim-endwise.git'
Plugin 'https://github.com/tpope/vim-git.git'

" plugin from http://vim-scripts.org/vim/scripts.html

" Unused for now. Potentially delete.
" Plugin 'https://github.com/kien/ctrlp.vim.git'
" Plugin 'https://github.com/jeetsukumaran/vim-buffergator.git'

Plugin 'L9'
Plugin 'https://github.com/ddollar/nerdcommenter.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'w0rp/ale'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/Lokaltog/vim-easymotion.git'
Plugin 'https://github.com/Shougo/unite.vim.git'
Plugin 'https://github.com/bling/vim-airline.git'
Plugin 'https://github.com/Shougo/vimproc.vim.git'
Plugin 'https://github.com/Twinside/vim-cuteErrorMarker.git'
Plugin 'https://github.com/bronson/vim-trailing-whitespace.git'
Plugin 'https://github.com/vim-scripts/a.vim.git'

Plugin 'https://github.com/terryma/vim-expand-region.git'
Plugin 'https://github.com/editorconfig/editorconfig-vim.git'
Plugin 'https://github.com/vim-scripts/ZoomWin.git'

Plugin 'https://github.com/Shougo/unite-outline.git'

Plugin 'https://github.com/xolox/vim-misc.git'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

" Snippets
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plugin 'https://github.com/tomtom/tlib_vim.git'
Plugin 'https://github.com/garbas/vim-snipmate.git'
Plugin 'https://github.com/honza/vim-snippets.git'

" Other random
Plugin 'godlygeek/tabular'
Plugin 'https://github.com/vadimr/bclose.vim.git'

Plugin 'https://github.com/othree/html5.vim.git'

Plugin 'https://github.com/jiangmiao/auto-pairs.git'

Plugin 'https://github.com/mtth/scratch.vim.git'
Plugin 'https://github.com/flazz/vim-colorschemes.git'
Plugin 'luochen1990/rainbow'
Plugin 'prabirshrestha/async.vim'
Plugin 'autozimu/LanguageClient-neovim'
Plugin 'flowtype/vim-flow'


" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""" After plugin settings """"""""""""""""""""""

:nnoremap <leader><leader> <C-^>

if !has('gui_running')
	highlight Pmenu ctermbg=200 ctermfg=white gui=bold
endif
