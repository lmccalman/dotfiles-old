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
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-vinegar'
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
Plugin 'vim-scripts/argtextobj.vim'        
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'majutsushi/tagbar'                
Plugin 'Raimondi/delimitMate'

" Visual
" ------
Plugin 'vim-scripts/Zenburn'
Plugin 'nanotech/jellybeans.vim'

" Maybe
" -----
" Plugin 'JuliaLang/julia-vim'
" Plugin 'tpope/vim-fugitive'          
" Plugin 'int3/vim-extradite'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'              
" Plugin 'vim-scripts/ini-syntax-definition'
" Plugin 'lambdatoast/elm.vim'

"Haskell
"-------
" Plugin 'travitch/hasksyn'
" Plugin 'eagletmt/ghcmod-vim'
" Plugin 'eagletmt/neco-ghc'
" Plugin 'Twinside/vim-hoogle'

" HTML
" ----
"Plugin 'vim-scripts/ragtag.vim'

" Plugin 'jdaddy.vim' for json!
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
set formatoptions=cq
set gdefault "this means I don't have to type g in a replace
set hidden
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
nnoremap ; :
vnoremap ; :
nnoremap <Space> ;
nnoremap <Space> ;
nnoremap ' `
nnoremap ` '


" My leader mappings
let mapleader = ","
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>w :w<CR>
"nnoremap <Leader>sw :SudoWrite<CR>
nnoremap <leader>h :HardTimeToggle
"Ag
nnoremap <Leader>f :Ag<Space>
nnoremap <Leader>fp :ProjectRootExe Ag<Space>
nnoremap <leader>l :CtrlPBuffer<CR>
nnoremap <leader>s :CtrlPBuffer<CR><CR> 
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
map Q <Nop> "No more 

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

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :GhcModCheckAsync<CR>
" Haskell Lint
nmap <silent> <leader>hl :GhcModLintAsync<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>
function! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h. :call Pointfree()<CR>

function! Pointful()
  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h> :call Pointful()<CR>

" usage -- :<loc>/foo/$t copy lines(?) matching foo
"copy
"cnoremap $t <cr>:t's<cr> 
"move
"cnoremap $m <cr>:m's<cr>
"delete
"cnoremap $d <cr>:d<cr>'s
" cnoremap $t <CR>:t''<CR>

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
  au FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

augroup ft_markdown
  au!
  au FileType markdown setlocal commentstring=[//]\:\ \#\ (%s)
augroup END

augroup ft_cpp
  au!
  au FileType cpp setlocal commentstring=//\ %s
augroup END

" Pretty unicode haskell symbols
let g:haskell_conceal_wide = 1
let g:haskell_conceal_enumerations = 1

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
let g:LatexBox_latexmk_options = '-pv'
let g:LatexBox_viewer = 'okular'
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:ctrlp_cmd = ':CtrlPBuffer'
" let g:ctrlp_extensions = ['mixed']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10'
let g:ctrlp_switch_buffer = 'Et'  "should be default
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files'] "see if this is too restrictive
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:haskell_tabular = 1
let g:necoghc_debug = 0
let g:necoghc_enable_detailed_browse = 1
let g:surround_indent = 1 "auto re-indent
let g:syntastic_auto_loc_list=0
let g:tagbar_autoclose = 1
let g:tagbar_left = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}

