" The Following addons need to be installed
" Vundle http://github.com/gmarik/vundle

" Sets up vundle stuff
set nocompatible
filetype off  " required!

se rtp+=~/.vim/bundle/vundle/ 
call vundle#rc()
"Let Vundle manage itself (required)
Bundle 'gmarik/vundle'

" General
" -------
Bundle 'ctrlp.vim'
Bundle 'surround.vim'           
Bundle 'repeat.vim'
Bundle 'Gundo'                
Bundle 'ack.vim'

" Coding
" ------
Bundle 'The-NERD-Commenter'    
Bundle 'fugitive.vim'          
Bundle 'argtextobj.vim'        
Bundle 'UltiSnips'
Bundle 'Tagbar'                
Bundle 'Syntastic'
Bundle 'mako.vim'
Bundle 'mako.vim--Torborg'

" Visual
" ------
Bundle 'Solarized'
Bundle 'Zenburn'

" HTML
" ----
Bundle 'Better-CSS-Syntax-for-Vim' 
Bundle 'ragtag.vim'

" On the Bench
" ------------
" Bundle 'LustyExplorer'         
" Bundle 'LaTeX-Box'              
" Bundle 'EasyMotion'
" Bundle 'pydoc.vim'             
" Bundle 'pyflakes.vim'          
" Bundle 'pep8'                  


filetype plugin indent on     " required!
" end of vundle stuff

set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp

" For security(?)
set modelines=0

" allow the . to execute once for each line of a visual block
vnoremap . :normal .<CR>

"disable that goddamn 'Entering Ex mode. Type 'visual' to go to Normal mode.'
" that I trigger 40x a day.
map Q <Nop>


let mapleader=","

" Indenting and tabbing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab "tab width determined by shiftwidth

" Ensures latex not plaintex chosen when opening a blank .tex file
let g:tex_flavor='latex'


"Default Formatting (ie python)
set textwidth=79
set formatoptions=cq

" Filetype specific changes
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
augroup END

" Wrap at 65 for mail
au BufRead /tmp/mutt-* setlocal textwidth=65 formatoptions=tcq
au BufNewFile,BufRead *.mako set filetype=mako

" let current working directory be that of current buffer
function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    exec "cd " . _dir
    unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

" Change indent continuously
vmap < <gv
vmap > >gv

" Fix indending for pasted blocks
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=

" Misc 
set grepprg=grep\ -nH\ $*
set scrolloff=20
set autoread
set encoding=utf-8
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start "Try not to use backspace!
set laststatus=2
set cmdheight=2 "what is this?
set relativenumber
set undofile
set lazyredraw "don't redraw whilst running macros
set hidden "can change buffers without sawing


" uses sane regex syntax not vim specific
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault "this means I don't have to type g in a replace
set incsearch
set showmatch
set hlsearch

"80 char warning
set colorcolumn=80
set wrap
set linebreak

"screen lines instead of global lines
nnoremap j gj
nnoremap k gk

" Visual Appearance
"
set guifont=Inconsolata\ Medium\ 13
colorscheme zenburn
syntax on
"set background=dark
"colorscheme solarized

if has('gui_running')
    set guioptions-=T   " Get rid of toolbar "
    set guioptions-=m   " Get rid of menu    "
    set guioptions+=LlRrb
    set guioptions-=LlRrb
endif

" My keybindings
"
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
noremap! jj <Esc>
inoremap <Esc> <NOP>
nnoremap ' `
nnoremap ` '
" some craziness to try
nnoremap <Space> :
"pasting properly
set pastetoggle=<F2>

" Surround.vim
" ------------
let g:surround_indent = 1 "auto re-indent


" Gundo
" -----
nnoremap <F4> :GundoToggle<CR>
let g:gundo_preview_bottom = 1 "let the preview span the bottom
let g:gundo_close_on_revert = 1

" CtrlP
" -----
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
nnoremap <Leader>lb :CtrlPBuffer<CR>
nnoremap <Leader>lf :CtrlPMixed<CR>


" LustyBufferExplorer
" -------------------
" let g:LustyExplorerDefaultMappings = 0
" nnoremap <Leader>lb :LustyBufferExplorer<CR>


" NerdCommenter
" -------------
let g:NERDSpaceDelims = 1
let g:NERDDefaultNesting = 0


"CSApprox
"
set t_Co=256
"let g:CSApprox_konsole=1

"Pyflakes
"let g:pyflakes_use_quickfix = 0

" Tagbar
"let g:tagbar_autoclose = 1
let g:tagbar_left = 1
"autocmd VimEnter * nested TagbarOpen
nnoremap TT :TagbarToggle<CR>
" LaTeX Forward Sync


"let g:LatexBox_viewer = 'okular'
"let g:LatexBox_latexmk_options = '-pv'


