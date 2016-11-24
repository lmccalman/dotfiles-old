

" ==== Plugins ==== {{{

" auto-install plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Buffers and Search
" ------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gabesoft/vim-ags'

" Navigation
" ----------
Plug 'justinmk/vim-sneak'
Plug 'takac/vim-hardtime'

" These appear to be the source of the weird write error
"Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags' "automatic generation of tag files

" Text Objects
" ------------
Plug 'tpope/vim-surround' "surrounding character pairs
Plug 'tommcdo/vim-lion' "tables
Plug 'bruno-/vim-vertical-move' "vertical blocks
Plug 'tweekmonster/braceless.vim' "indentation levels
Plug 'tpope/vim-commentary' "comments
Plug 'b4winckler/vim-angry' "function arguments

" Prose
" -----
Plug 'reedes/vim-wordy'
Plug 'lervag/vimtex'

" Snippets and completion
" -----------------------
"  pip install --upgrade jedi flake8
Plug 'raimondi/delimitmate'
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'

" Visual
" ------
" Plug 'scrooloose/syntastic' "linting
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kshenoy/vim-signature' "for displaying marks on the left ruler
Plug 'vim-scripts/Zenburn'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'oblitum/rainbow'

" Etc
" ---
Plug 'neomake/neomake'
Plug 'dbakker/vim-projectroot'
Plug 'tpope/vim-eunuch' "for :SudoWrite and etc
Plug 'tpope/vim-repeat' "enables repeats on tpopes plugins
Plug 'AndrewRadev/splitjoin.vim' "1 line ifs / multiline ifs
Plug 'sjl/gundo.vim'
Plug 'chrisbra/vim-diff-enhanced'

call plug#end()
" }}}

syntax on
filetype plugin indent on 


" ==== Big Changes ==== {{{
noremap! jk <Esc>
nnoremap <Space> :
nnoremap <cr> o<esc>
let mapleader = ","
" No Entering Ex mode
" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq


" }}}

" ==== Diffs ==== {{{
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
" }}}

" ==== Folding ==== {{{
set foldclose=all
set foldlevel=0
set foldlevelstart=0
set foldmethod=marker
" }}}

" ==== IO ==== {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" Enable undofiles (writebackup on by default)
set undofile
set writebackup
set autoread
set autowrite
au FocusLost * :echo "Focus lost: saving all buffers" | :wall
" Remove trailing whitespace in python
autocmd BufWritePre *.py :%s/\s\+$//e
" Save cursor, folds etc from last edit

set viewoptions-=options
set sessionoptions-=options
set viewoptions-=localoptions
set sessionoptions-=localoptions

autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") |
\   execute "normal! g`\"" |
\ endif

" }}}

" ==== Formatting ==== {{{
set autoindent
set formatoptions=tcnjq1
set linebreak
set expandtab
set softtabstop=-1
set shiftwidth=0
set noshiftround
set tabstop=2
set textwidth=79
set virtualedit=block
set wrap
"}}}


" ==== Display ==== {{{
set termguicolors
set number
set relativenumber " off so I use S more
set title
set ruler
set scrolloff=9999
set sidescroll=1
set sidescrolloff=1
set showmatch
set lazyredraw "don't redraw whilst running macros
set display=uhex " affects the last line somehow
set cmdheight=2
set cursorline
set colorcolumn=+1

" Visual Appearance
set guifont=Anonymous\ Pro\ for\ Powerline\ 10

let g:rainbow_active = 1

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

" let g:syntastic_auto_loc_list=0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1

let g:limelight_default_coefficient = 0.5
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


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

" }}}

" ==== Navigation ==== {{{
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
"screen lines instead of global lines
nnoremap j gj
nnoremap k gk

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Hardtime
let g:hardtime_allow_different_key = 0
let g:hardtime_default_on = 1

let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "e", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "w", "b", "e", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]

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


let g:neomake_open_list = 1
let g:neomake_list_height = 10

" }}}

" ==== Editing ==== {{{
set backspace=indent,eol,start "Try not to use backspace!
nnoremap <leader>h :HardTimeToggle
" Change indent continuously
vmap < <gv
vmap > >gv
" allow the . to execute once for each line of a visual block
vnoremap . :normal .<CR>
" make Y consistent with C and D. See :help Y.
nnoremap Y y$
" spelling fix
nnoremap zz z=
nnoremap z= :echo "use zz you idiot"<cr>
" Dates
:nnoremap <F6> "=strftime("%d_%b_%Y")<CR>P
:inoremap <F6> <C-R>=strftime("%d_%b_%Y")<CR>

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w79"

" default text object is P, alse try [[ and ]]
autocmd FileType python BracelessEnable +indent
autocmd FileType haml,yaml,coffee BracelessEnable +indent +fold

" angry (function argument text objects)
let g:angry_disable_maps = 1
vmap <silent> af <Plug>AngryOuterPrefix
omap <silent> af <Plug>AngryOuterPrefix
vmap <silent> if <Plug>AngryInnerPrefix
omap <silent> if <Plug>AngryInnerPrefix

vmap <silent> aF <Plug>AngryOuterSuffix
omap <silent> aF <Plug>AngryOuterSuffix
vmap <silent> iF <Plug>AngryInnerSuffix
omap <silent> iF <Plug>AngryInnerSuffix

let g:surround_indent = 1 "auto re-indent

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif


" }}}

" ==== Searching ==== {{{

set gdefault "this means I don't have to type g in a replace
set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
set ignorecase
set matchpairs+=<:>  "for html etc
set smartcase
set wildmode=list:longest

nnoremap / /\M
vnoremap / /\M
nnoremap ? ?\M
vnoremap ? ?\M
nnoremap :s/ :s/\M

"Ag
nnoremap <Leader>/h :Ags<Space>
nnoremap <Leader>/ :ProjectRootExe :Ags<Space>
"FZF
nnoremap <silent> <leader>g :FzfCommits<CR>
nnoremap <silent> <leader>l :FzfLines<CR>
nnoremap <silent> <leader>t :FzfTags<CR>

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

let g:fzf_nvim_statusline = 1 " disable statusline overwriting
let g:fzf_command_prefix = 'Fzf'

let g:ags_enable_async = 1

" }}}

" ==== Buffers ==== {{{
set autochdir
nnoremap <leader>s :b#<CR>
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>w :update<CR>
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>

" }}}

" ==== Clipboard and Undo ==== {{{
set pastetoggle=<leader>p
set clipboard=unnamedplus

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_


nnoremap <F4> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 20
let g:gundo_right = 0
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" }}}

" ==== Filetypes ==== {{{
au BufRead,BufNewFile *.dock setfiletype dockerfile
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mako set filetype=mako
" ensures latex not plaintex chosen when opening a blank .tex file
let g:tex_flavor='latex'
augroup ft_tex
    au!
    au FileType tex setlocal formatoptions=tcqr 
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
    au FileType python let b:delimitMate_expand_inside_quotes = 1
    au FileType python let b:delimitMate_nesting_quotes = ['"']
augroup END
augroup ft_markdown
  au!
  au FileType markdown setlocal commentstring=[//]\:\ \#\ (%s)
augroup END
augroup ft_cpp
  au!
  au FileType cpp setlocal commentstring=//\ %s
augroup END
augroup ft_mail
  " Mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail 
  autocmd BufRead,BufNewFile *mutt-* setlocal tw=72 spell formatoptions=tcqj
augroup END

" }}}

" ==== Completion ==== {{{
let g:jedi#show_call_signatures = "1"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:ultisnips_python_style="numpy"

" }}}

