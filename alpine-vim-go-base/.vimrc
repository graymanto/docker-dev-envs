let mapleader = ","
inoremap jj <Esc>
imap <C-j> <Right><Plug>snipMateNextOrTrigger
nmap <C-tab> :bnext<cr>
nmap <C-S-tab> :bprevious<cr>
nmap <leader>sc :SyntasticCheck<CR>
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
endif

""""""""""" Resize  mode """""""""""""""

nnoremap <M-Right> :vertical resize +5<CR>
nnoremap <M-Left>  :vertical resize -5<CR>
nnoremap <M-Up>    :resize -5<CR>
nnoremap <M-Down>  :resize +5<CR>

" For terminal
nnoremap [1;3C     :vertical resize +5<CR>
nnoremap [1;3D     :vertical resize -5<CR>
nnoremap [1;3A     :resize -5<CR>
nnoremap [1;3B     :resize +5<CR>

""""""""""""""""""""""""""""""""""""""""

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
nmap <Leader>pp "+p

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set tabstop=4

colorscheme desert

set dir-=.

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files

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

set nocompatible              " be iMproved, required
filetype off                  " required

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

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

nnoremap <leader>gto :YcmCompleter GoTo<CR>
nnoremap <leader>gti :YcmCompleter GoToImprecise<CR>
nnoremap <F12> :YcmCompleter GoToImprecise<CR>

""""""""""" Tabularize """""""""""""""

vnoremap <leader>ta :Tabularize assignment<CR>

""""""""""" Tagbar """""""""""""""

nnoremap <leader>tb :TagbarToggle<CR>

""""""""""" Unite """""""""""""""
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_async_command=['ag', '--follow',
			\ '--nogroup', '--nocolor', '--hidden', '-g', '']

nnoremap <space>u :Unite -start-insert file_rec/async<cr>
nnoremap <space>i :Unite -start-insert file_rec/git<cr>
nnoremap <leader>uunc :Unite -quick-match change<cr>
nnoremap <space>c :Unite -quick-match change<cr>
nnoremap <leader>u/ :Unite grep:.<cr>
nnoremap <leader>ur :UniteResume<cr>
nnoremap <leader>un :UniteNext<cr>
nnoremap <leader>un :UnitePrevious<cr>
nnoremap <leader>bb :Unite -quick-match buffer<cr>
nnoremap <leader>uf :Unite function<cr>
nnoremap <space>y :Unite -quick-match history/yank<cr>
nnoremap <space>f :Unite -start-insert buffer<cr>

nnoremap <leader>gg :execute 'Unite gtags/def'<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>ge :execute 'Unite gtags/grep'<CR>
vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>

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

""""""""""" Go settings """""""""""""""

augroup golangac
	autocmd!
	func! FormatGoLang()
		let l:winview = winsaveview()
		:exe '%!gofmt'
		call winrestview(l:winview)
	endfunc
	autocmd FileType go nnoremap <leader>fgo :call FormatGoLang()<CR>
	autocmd FileType go nnoremap <leader>gto :GoDef<CR>
	autocmd FileType go nnoremap <leader>gbu :GoBuild<CR>
	autocmd FileType go nnoremap <leader>gtt :GoTest<CR>
	autocmd FileType go nnoremap <leader>gtf :GoTestFunc<CR>
	autocmd FileType go nnoremap <leader>gtc :GoCoverage<CR>
	autocmd FileType go nnoremap <leader>gli :GoImplements<CR>
	autocmd FileType go nnoremap <leader>gla :GoAlternate<CR>
	autocmd FileType go set shiftwidth=4 tabstop=4
	au FileType go nnoremap <leader>fff :GoFmt<CR>
	let g:go_fmt_autosave = 1
	let g:go_fmt_command = "goimports"

	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_types = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_build_constraints = 1

	let g:go_metalinter_enabled = ['vet', 'golint']
	let g:go_auto_type_info = 1
	" let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
	" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
	" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
	let g:go_list_type = "quickfix"
	set updatetime=100
augroup END

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

Plugin 'L9'
Plugin 'https://github.com/ddollar/nerdcommenter.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'w0rp/ale'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
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

" Tags
Plugin 'https://github.com/Shougo/unite-outline.git'

"Other language specific
Plugin 'https://github.com/xolox/vim-misc.git'
Plugin 'fatih/vim-go'

" Snippets
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plugin 'https://github.com/tomtom/tlib_vim.git'
Plugin 'https://github.com/garbas/vim-snipmate.git'
Plugin 'https://github.com/honza/vim-snippets.git'

" Other random
Plugin 'godlygeek/tabular'
Plugin 'https://github.com/vadimr/bclose.vim.git'
Plugin 'https://github.com/jiangmiao/auto-pairs.git'

Plugin 'https://github.com/mtth/scratch.vim.git'
Plugin 'https://github.com/flazz/vim-colorschemes.git'

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
