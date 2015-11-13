" Vundle
"-------
set nocompatible 
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" General
" -------
Plugin 'justinmk/vim-sneak'
Plugin 'takac/vim-hardtime'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch' "for :SudoWrite and etc
Plugin 'tommcdo/vim-lion' "tabularize replacement
Plugin 'rking/ag.vim'
Plugin 'dbakker/vim-projectroot'
Plugin 'bruno-/vim-vertical-move'
Plugin 'SirVer/ultisnips'

" Coding
" ------
Plugin 'tpope/vim-commentary'
Plugin 'b4winckler/vim-angry'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'majutsushi/tagbar'                
Plugin 'Raimondi/delimitMate'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'lervag/vimtex'
Plugin 'davidhalter/jedi-vim'
Plugin 'bitc/vim-hdevtools'
Plugin 'dag/vim2hs'

" Visual
" ------
Plugin 'vim-scripts/Zenburn'
Plugin 'nanotech/jellybeans.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'


call vundle#end()

filetype plugin indent on
syntax on

set autochdir
set autoread
set backspace=indent,eol,start "Try not to use backspace!
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set cmdheight=2 "what is this?
set cursorline
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
set encoding=utf-8
set expandtab
set foldlevel=99
set formatoptions=cq
set gdefault "this means I don't have to type g in a replace
set hidden "can change buffers without sawing
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw "don't redraw whilst running macros
set linebreak
set matchpairs+=<:>  "for html etc
set matchtime=2 "0.2 seconds
set modelines=0
set nostartofline
set number
set relativenumber
set ruler
set scrolloff=9999
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smarttab "tab width determined by shiftwidth
set softtabstop=2
set tabstop=2
set textwidth=79
set ttyfast
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set undofile
set viminfo^=%
set virtualedit=block
set wildmenu
set wildmode=list:longest
set wrap

"N00bs beware
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
inoremap  <Esc>    <NOP>

noremap! jk <Esc>
nnoremap <Space> :

" My leader mappings
let mapleader = ","
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>w :w<CR>
"nnoremap <Leader>sw :SudoWrite<CR>
nnoremap <leader>h :HardTimeToggle
" haskell?
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
"Ag
nnoremap <Leader>f :Ag<Space>
nnoremap <Leader>fp :ProjectRootExe Ag<Space>
"Ctrlp
nnoremap <leader>l :CtrlPMixed<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>s :b#<CR>
" Change indent continuously
vmap < <gv
vmap > >gv
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v
nnoremap TT :TagbarToggle<CR>

"disable that goddamn 'Entering Ex mode. Type 'visual' to go to Normal mode.'
" that I trigger 40x a day.
map Q <Nop> 

" allow the . to execute once for each line of a visual block
vnoremap . :normal .<CR>
map <C-K> <C-U>
map <C-J> <C-D>
imap <C-K> <C-O><C-U>
imap <C-J> <C-O><C-D>
"pasting properly
map  <F2> :set paste<CR>i
imap <F2> <ESC>:set paste<CR>i<Right>
au InsertLeave * set nopaste
" Dates
:nnoremap <F5> "=strftime("%d_%b_%Y")<CR>P
:inoremap <F5> <C-R>=strftime("%d_%b_%Y")<CR>
" make Y consistent with C and D. See :help Y.
nnoremap Y y$
"screen lines instead of global lines
nnoremap j gj
nnoremap k gk
" Paste from system clipboard
noremap <leader>p <esc>o<esc>"+]p
" Yank to system clipboard
noremap <leader>y "+y

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Filetype specific changes
" ini files
au BufRead,BufNewFile *.gdf setfiletype ini
au BufRead,BufNewFile *.conf setfiletype ini
" ensures latex not plaintex chosen when opening a blank .tex file
let g:tex_flavor='latex'

augroup ft_tex
    au!
    au FileType tex setlocal formatoptions=tcqr 
    au FileType tex setlocal textwidth=79 
    au FileType tex setlocal shiftwidth=2 
    au FileType tex setlocal tabstop=2 
    au FileType tex setlocal spelllang=en_gb 
    au FileType tex setlocal iskeyword+=: 
    au FileType tex setlocal makeprg=rubber\ -m\ xelatex\ % 
    au FileType tex setlocal errorformat=%f:%l:\ %m
augroup END

augroup ft_python
    au!
    au FileType python setlocal formatoptions=cqr 
    au FileType python setlocal textwidth=79
    au FileType python setlocal wildignore+=*.py[co]
    au FileType python setlocal tabstop=4
    au FileType python setlocal shiftwidth=4
    au FileType python setlocal softtabstop=4
    au FileType python let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
augroup END

augroup ft_haskell
  au!
  " au FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

augroup ft_markdown
  au!
  au FileType markdown setlocal commentstring=[//]\:\ \#\ (%s)
augroup END

augroup ft_cpp
  au!
  au FileType cpp setlocal commentstring=//\ %s
augroup END

" Wrap at 65 for mail
au BufRead /tmp/mutt-* setlocal textwidth=65 formatoptions=tcq
au BufNewFile,BufRead *.mako set filetype=mako

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \ exe "normal! g`\"" |
       \ endif
augroup END

" Use par for prettier line formatting
" :set formatprg=par\ -w60
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w79"
" uses sane regex syntax not vim specific
set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
set grepformat=%f:%l:%c:%m

" Visual Appearance
set guifont=Anonymous\ Pro\ for\ Powerline\ 10

set t_Co=256
colorscheme jellybeans
if has('gui_running')
    set guioptions-=T   " Get rid of toolbar "
    set guioptions-=m   " Get rid of menu    "
    set guioptions+=LlRrb
    set guioptions-=LlRrb
endif


" Plugin options
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1


" CtrlP
" note, use .agignore to ignore shite here
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" 10x faster at matching
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10'
let g:ctrlp_switch_buffer = 'Et'  "should be default

let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1

let g:surround_indent = 1 "auto re-indent
let g:syntastic_auto_loc_list=0
let g:tagbar_autoclose = 1
let g:tagbar_left = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}

"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T


let g:angry_disable_maps = 1
vmap <silent> af <Plug>AngryOuterPrefix
omap <silent> af <Plug>AngryOuterPrefix
vmap <silent> if <Plug>AngryInnerPrefix
omap <silent> if <Plug>AngryInnerPrefix

vmap <silent> aF <Plug>AngryOuterSuffix
omap <silent> aF <Plug>AngryOuterSuffix
vmap <silent> iF <Plug>AngryInnerSuffix
omap <silent> iF <Plug>AngryInnerSuffix



" Visuals
let g:limelight_default_coefficient = 0.5
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0
" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

