" TODO write README, how to setup (nvim, vim-plug)

" TODO
"  - working with buffers, tabs
"  - plugins: snippets, gundo, ag.vim
"  - backups and history: use -u and ctrl-r after rewrite and reopen file
"  - search: ctags
"  - view: airline

" Basic {{{
  set nocompatible

  set shell=/bin/bash
  set exrc
  set modelines=1

  let mapleader=','

  filetype plugin indent on

  set clipboard=unnamed

  set autoread
  set autowriteall

  " Folding {{{
    set foldenable        " enable folding
    set foldlevelstart=10 " open most folds by default
    set foldnestmax=10    " 10 nested fold max
    set foldmethod=indent " fold based on indent level
  " }}}

  " Swap and Backups {{{
    set updatecount=0
    set noswapfile
    set nobackup
    set nowritebackup
  " }}}

  " Split {{{
    " open new split panes to right and bottom, which feels more natural
    set splitbelow
    set splitright
  " }}}
" }}}

" Plugins {{{
  let g:plug_window='new'

  call plug#begin('~/.nvim/plugged')

  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'vim-scripts/vim-auto-save'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-easy-align'
  Plug 'morhetz/gruvbox'
  Plug 'easymotion/vim-easymotion'
  Plug 'shime/vim-livedown'
  Plug 'DataWraith/auto_mkdir'
  Plug 'pangloss/vim-javascript'

  call plug#end()
" }}}

" Plugins Settings {{{

  " autosave {{{
    let g:auto_save = 1                " enable autosave
    let g:auto_save_in_insert_mode = 0 " do not save while in insert mode
  " }}}

  " fugitive {{{
    if !exists('s:git_status_line_added')
      set statusline+=%{fugitive#statusline()}
      let s:git_status_line_added=1
    endif
  " }}}

  " ctrlp {{{
    let g:ctrlp_map='<leader>t'
    let g:ctrlp_use_caching=0
    " order matching files top to bottom with ttb (from top to bottom)
    let g:ctrlp_match_window = 'bottom,order:ttb'
    " always open files in new buffers
    let g:ctrlp_switch_buffer = 0
    " allow change the working directory during a vim session
    let g:ctrlp_working_path_mode = 0
  " }}}

  " netrw {{{
    let g:netrw_preview=1
    let g:netrw_alto=0
  " }}}

  " NerdTREE {{{
    let NERDTreeShowHidden=1
    let g:NERDTreeWinSize=40
  " }}}

" }}}

" Shortcuts {{{
  noremap <Leader>e :NERDTreeFind<CR>
  noremap <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>

  noremap <Leader>gs :Gstatus<CR>
  noremap <Leader>gb :Gblame<CR>

  noremap <C-p> :LivedownToggle<CR>

  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  " fast exit to normal mode
  inoremap jk <esc>
  vnoremap <C-c> <esc>

  " space open/closes folds
  nnoremap <space> za

  " switching windows
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l
  noremap <C-h> <C-w>h

  " buffer navigation
  noremap <leader>q :bp<CR>
  noremap <leader>w :bn<CR>

  " close buffer
  noremap <leader>c :bd<CR>

  " vmap for maintain Visual Mode after shifting > and <
  vmap < <gv
  vmap > >gv

  " set working directory
  nnoremap <leader>. :lcd %:p:h<CR>

  " split
  noremap <Leader>h :<C-u>split<CR>
  noremap <Leader>v :<C-u>vsplit<CR>

  " movement {{{
    " move visual block
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

    " move vertically by visual line
    nnoremap j gj
    nnoremap k gk

    " move to beginning/end of line
    nnoremap B ^
    nnoremap E $
  " }}}

  nnoremap <silent> <leader><space> :nohlsearch<cr>

  " autocomplete
  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <S-Tab> <c-n>
" }}}

" View {{{
  syntax enable

  colorscheme gruvbox
  set background=dark

  set ruler       " show the cursor position all the time
  set cursorline  " color current line
  set list        " show invisible characters

  " wrap long lines
  set wrap
  set showbreak=↪\

  " display extra whitespace
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

  set colorcolumn=80

  " numbers
  set number
  set numberwidth=5

  " have some context around the current line always on screen
  set scrolloff=3

  " show (partial) command in the last line of the screen
  set showcmd

  " autocomplete
  set wildmode=list:longest,list:full

  " visual autocomplete for command menu
  set wildmenu
" }}}

" Tabs {{{
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set shiftround
  set expandtab
" }}}

" Search {{{
  set ignorecase
  set smartcase
  set incsearch

  set hlsearch  " Enable search highlighting,
  nohlsearch    " but do not highlight last search on startup
" }}}

" Functions {{{
  function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
  endfunction

  function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
  endfunction
" }}}

" Autogroups {{{
  augroup configgroup
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

    " arbre (https://github.com/activeadmin/arbre) processing
    autocmd BufEnter *.arb setlocal filetype=ruby

    autocmd BufLeave * set norelativenumber number
    autocmd BufEnter * set relativenumber
  augroup END
" }}}

" NeoVim Specific {{{
  " see https://github.com/neovim/neovim/issues/2048
  if has('nvim')
    nmap <BS> <C-W>h
  endif

  if !has('nvim')
    set encoding=utf-8
  endif

  " Disable vim auto visual mode using mouse
  set mouse-=a

  " Neo Vim cursor shape
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
" }}}

" vim:foldmethod=marker:foldlevel=0
