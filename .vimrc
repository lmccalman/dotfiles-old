
" auto-install plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plug Plugins
call plug#begin('~/.vim/bundle')

" General
" -------
Plug 'kshenoy/vim-signature'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'takac/vim-hardtime'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch' "for :SudoWrite and etc
Plug 'tommcdo/vim-lion' "tabularize replacement
Plug 'gabesoft/vim-ags'
Plug 'dbakker/vim-projectroot'
Plug 'bruno-/vim-vertical-move'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Coding
" ------
Plug 'tpope/vim-commentary'
Plug 'b4winckler/vim-angry'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'majutsushi/tagbar'                
Plug 'Raimondi/delimitMate'
Plug 'michaeljsmith/vim-indent-object'
Plug 'lervag/vimtex'
Plug 'davidhalter/jedi-vim'
Plug 'bitc/vim-hdevtools'
Plug 'dag/vim2hs'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'

" Visual
" ------
Plug 'vim-scripts/Zenburn'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()


set autochdir
set autoread
set backspace=indent,eol,start "Try not to use backspace!
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set clipboard=unnamed,unnamedplus
set cmdheight=2 "what is this?
set cursorline
set colorcolumn=80
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
set noswapfile
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
set textwidth=0
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
nnoremap <expr> <leader>e ':e '.projectroot#guess().'/'
nnoremap <Leader>w :w<CR>
nnoremap <Leader>sw :SudoWrite<CR>
nnoremap <leader>h :HardTimeToggle
" haskell?
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
"Ag
nnoremap <Leader>/h :Ags<Space>
nnoremap <Leader>/ :ProjectRootExe :Ags<Space>
"FZF
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>g :FzfCommits<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfLines<CR>
nnoremap <silent> <leader>t :FzfTags<CR>
nnoremap <leader>s :b#<CR>

" nnoremap <silent> <leader>gs :Gstatus<CR>
" nnoremap <silent> <leader>gd :Gdiff<CR>
" nnoremap <silent> <leader>gc :Gcommit<CR>
" nnoremap <silent> <leader>gb :Gblame<CR>
" nnoremap <silent> <leader>ge :Gedit<CR>
" nnoremap <silent> <leader>gE :Gedit<space>
" nnoremap <silent> <leader>gr :Gread<CR>
" nnoremap <silent> <leader>gR :Gread<space>
" nnoremap <silent> <leader>gw :Gwrite<CR>
" nnoremap <silent> <leader>gW :Gwrite!<CR>
" nnoremap <silent> <leader>gq :Gwq<CR>
" nnoremap <silent> <leader>gQ :Gwq!<CR>

" let g:SignatureMarkerTextHL = 'Typedef'
"   let g:SignatureMap = {
"     \ 'Leader'             :  "m",
"     \ 'PlaceNextMark'      :  "m,",
"     \ 'ToggleMarkAtLine'   :  "m.",
"     \ 'PurgeMarksAtLine'   :  "m-",
"     \ 'DeleteMark'         :  "dm",
"     \ 'PurgeMarks'         :  "m<Space>",
"     \ 'PurgeMarkers'       :  "m<BS>",
"     \ 'GotoNextLineAlpha'  :  "",
"     \ 'GotoPrevLineAlpha'  :  "",
"     \ 'GotoNextSpotAlpha'  :  "",
"     \ 'GotoPrevSpotAlpha'  :  "",
"     \ 'GotoNextLineByPos'  :  "]'",
"     \ 'GotoPrevLineByPos'  :  "['",
"     \ 'GotoNextSpotByPos'  :  "]`",
"     \ 'GotoPrevSpotByPos'  :  "[`",
"     \ 'GotoNextMarker'     :  "[+",
"     \ 'GotoPrevMarker'     :  "[-",
"     \ 'GotoNextMarkerAny'  :  "]=",
"     \ 'GotoPrevMarkerAny'  :  "[=",
"     \ 'ListLocalMarks'     :  "m/",
"     \ 'ListLocalMarkers'   :  "m?"
"     \ }

" Change indent continuously
vmap < <gv
vmap > >gv
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v
nnoremap TT :TagbarToggle<CR>


" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Same as normal H/L behavior, but preserves scrolloff
nnoremap H :call JumpWithScrollOff('H')<CR>
nnoremap L :call JumpWithScrollOff('L')<CR>
function! JumpWithScrollOff(key) " {{{
  set scrolloff=0
  execute 'normal! ' . a:key
  set scrolloff=999
endfunction " }}}


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
" au BufRead /tmp/mutt-* setlocal textwidth=65 formatoptions=tcq

" au BufRead /tmp/mutt-* set tw=72

augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail 
  autocmd BufRead,BufNewFile *mutt-*              setlocal tw=72 spell formatoptions=tcqj
augroup END


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

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if !has('nvim')
  set t_Co=256
endif


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

" FZF
let g:fzf_nvim_statusline = 1 " disable statusline overwriting
let g:fzf_command_prefix = 'Fzf'

" Hardtime
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1

let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "e", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "w", "b", "e", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]

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

"Ags
let g:ags_enable_async = 1


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

"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!


function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
" autocmd VimEnter * Goyo

