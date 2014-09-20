" NeoBundle Initialisation
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" General
" -------
" to get -- matchit.vim?
NeoBundle 'justinmk/vim-sneak'
" NeoBundle 'takac/vim-hardtime'
NeoBundle 'mrtazz/simplenote.vim'
NeoBundle 'bruno-/vim-vertical-move'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-tag'
"NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'mbbill/undotree'                
" NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'godlygeek/tabular'

"Simplenote
"----------

"Haskell
"-------
NeoBundle 'travitch/hasksyn'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'Twinside/vim-hoogle'

" Coding
" ------
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'          
NeoBundle 'int3/vim-extradite'
NeoBundle 'vim-scripts/argtextobj.vim'        
NeoBundle 'SirVer/ultisnips'
NeoBundle 'majutsushi/tagbar'                
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'              
NeoBundle 'vim-scripts/ini-syntax-definition'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'AndrewRadev/splitjoin.vim'

" Visual
" ------
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'nanotech/jellybeans.vim'

" HTML
" ----
NeoBundle 'vim-scripts/ragtag.vim'

" On the Bench
" ------------
" NeoBundle 'jdaddy.vim' for json!
" NeoBundle 'The-NERD-Commenter'    
" NeoBundle 'tpope/vim-dispach'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" end of NeoBundle stuff

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

"Folds Rule(?)
set foldenable
set foldmethod=syntax
set foldlevel=99

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Filetype specific changes
" ini files
au BufRead,BufNewFile *.gdf setfiletype ini
au BufRead,BufNewFile *.conf setfiletype ini

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
" Remember info about open buffers on close
set viminfo^=%

" let current working directory be that of current buffer
set autochdir

" Change indent continuously
vmap < <gv
vmap > >gv

" Fix indending for pasted blocks
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=
" Use par for prettier line formatting
" :set formatprg=par\ -w60
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w79"

" Misc 
set scrolloff=20
set autoread
set encoding=utf-8
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
set number
set undofile
set lazyredraw "don't redraw whilst running macros
set hidden "can change buffers without sawing

" uses sane regex syntax not vim specific
set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
set grepformat=%f:%l:%c:%m

nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v

 " folds {{{
    nnoremap zr zr:echo &foldlevel<cr>
    nnoremap zm zm:echo &foldlevel<cr>
    nnoremap zR zR:echo &foldlevel<cr>
    nnoremap zM zM:echo &foldlevel<cr>
" }}}

 " make Y consistent with C and D. See :help Y.
nnoremap Y y$

set ignorecase
set smartcase
set gdefault "this means I don't have to type g in a replace
set incsearch
set showmatch
"set hlsearch

"80 char warning
set wrap
set linebreak

"screen lines instead of global lines
nnoremap j gj
nnoremap k gk

" Visual Appearance
"
" set guifont=Inconsolata\ Medium\ 15
set guifont=Anonymous\ Pro\ for\ Powerline\ 11
" set guifont=Anonymous\ Pro\ 15
" set guifont=Droid\ Sans\ Mono\ 15
" set guifont=Source\ Code\ Pro\ Medium\ 14

" colorscheme zenburn
set t_Co=256
colorscheme jellybeans
syntax on

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
noremap! jk <Esc>
inoremap <Esc> <NOP>

map <C-K> <C-U>
map <C-J> <C-D>
imap <C-K> <C-O><C-U>
imap <C-J> <C-O><C-D>
set nostartofline

" some craziness to try
" nnoremap <Space> :
" nnoremap : <NOP>
nnoremap <Leader>w :w<CR>
"pasting properly
map  <F2> :set paste<CR>i
imap <F2> <ESC>:set paste<CR>i<Right>
au InsertLeave * set nopaste

" Dates
:nnoremap <F5> "=strftime("%d_%b_%Y")<CR>P
:inoremap <F5> <C-R>=strftime("%d_%b_%Y")<CR>

" Syntastic
" ---------
let g:syntastic_auto_loc_list=0

" Surround.vim
" ------------
let g:surround_indent = 1 "auto re-indent

" Unite.vim
" -----
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 20
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
" let g:unite_enable_short_source_names = 1
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_rec_max_cache_files=5000
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts =
\ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt=''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec', 'filters',
\ ['converter_relative_word', 'matcher_fuzzy',
\ 'sorter_rank', 'converter_relative_abbr'])


" Execute help.
nnoremap <C-h>  :<C-u>Unite -start-insert help<CR>
" Execute help by cursor keyword.
nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

" call unite#custom#source('grep', 'filters',
"       \ ['converter_relative_word','converter_relative_abbr'])
" call unite#custom#source('file_rec/async','sorters','sorter_rank')

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/'], '\|'))


" try -quick-match and auto-preview -auto-highlight -unique -no-split
"list currently open buffers
nnoremap <leader>lb :<C-u>Unite -no-split -immediately -buffer-name=buffers buffer file_mru<cr>
"list files in current working directory
nnoremap <leader>ld :<C-u>Unite -no-split -buffer-name=files file<cr>
"recursive list from current working direcory or project directory
nnoremap <leader>lf :<C-u>Unite -no-split -buffer-name=files file_rec/async:!<cr>
nnoremap <leader>lg :<C-u>Unite -no-split -buffer-name=files file_rec/git<cr>
nnoremap <leader>lr :<C-u>Unite -no-split -buffer-name=mru file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline outline<cr>
nnoremap <leader>ly :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>/ :Unite -no-split -buffer-name=grep -auto-preview grep:!<cr>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <buffer> jk <Plug>(unite_insert_leave)
  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB> <Plug>(unite_select_next_line)
  nmap <buffer> <C-j> <Plug>(unite_toggle_auto_preview)
  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r unite#do_action('rename')
  endif
  nnoremap <silent><buffer><expr> cd unite#do_action('lcd')
endfunction


" Paste from system clipboard
noremap <leader>p <esc>o<esc>"+]p
" Yank to system clipboard
noremap <leader>y "+y


" Tagbar
" ------
let g:tagbar_autoclose = 1
let g:tagbar_left = 1
nnoremap TT :TagbarToggle<CR>

" vimwiki
" -------
" let g:vimwiki_list = [{'path': '~/wiki/personal', 'syntax': 'markdown', 'index': 'Home', 'ext': '.md'},
"       \   {'path': '~/wiki/joint', 'syntax': 'markdown', 'index': 'Home', 'ext': '.md'},
"       \                {'path': '~/wiki/public', 'syntax': 'markdown', 'index': 'Home', 'ext': '.md'}]

" LaTeX-Box
" ---------
let g:LatexBox_viewer = 'okular'
let g:LatexBox_latexmk_options = '-pv'

" Airline
" -------
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1

" YouCompleteMe
" -------------
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" NeoGHC
" ------
let g:necoghc_enable_detailed_browse = 1
let g:necoghc_debug = 0


" vim-align
" =========
" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

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

" Vim Hardtime
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
nnoremap <leader>h :HardTimeToggle

"Splitjoin
"use jS and gJ

" " Sneak
" "replace 'f' with inclusive 1-char Sneak
" nmap f <Plug>Sneak_f
" nmap f <plug>sneak_F
" xmap f <plug>sneak_f
" xmap f <plug>sneak_F
" omap f <plug>sneak_f
" omap f <plug>sneak_F
" "replace 't' with exclusive 1-char Sneak
" nmap t <plug>sneak_t
" nmap t <plug>sneak_T
" xmap t <plug>sneak_t
" xmap t <plug>sneak_T
" omap t <plug>sneak_t
" omap T <Plug>Sneak_T
" let g:sneak#streak = 1

let g:SimplenoteUsername = "lachlan@mccalman.info"
let g:SimplenotePassword = system('pass simplenote')

let g:netrw_browsex_viewer= "xdg-open"
