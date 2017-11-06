" Config file for NeoVim
"
" author: Sergey Zabolotnov (sergey.zabolotnov@gmail.com)
"

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

  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'vim-scripts/vim-auto-save'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-unimpaired'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-easy-align'
  Plug 'DataWraith/auto_mkdir'
  Plug 'pangloss/vim-javascript'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-fugitive'
  Plug 'chriskempson/base16-vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'janko-m/vim-test'
  Plug 'dag/vim-fish'

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

  " netrw {{{
    let g:netrw_preview=1
    let g:netrw_alto=0
  " }}}

  " NerdTREE {{{
    let NERDTreeShowHidden=1
    let g:NERDTreeWinSize=40
  " }}}

  " Vim Tests {{{
    nmap <silent> <leader>r :TestNearest<CR>
    nmap <silent> <leader>ar :TestFile<CR>

    let test#strategy = "neovim"
    let test#ruby#rspec#executable = 'env USE_SPRING=1 bin/rspec'
  " }}}

" }}}

" Shortcuts {{{
  noremap <Leader>e :NERDTreeFind<CR>
  noremap <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>

  noremap <Leader>gs :Gstatus<CR>
  noremap <Leader>gb :Gblame<CR>
  noremap <Leader>gd :Gdiff<CR>

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
  noremap <A-j> <C-w>j
  noremap <A-k> <C-w>k
  noremap <A-l> <C-w>l
  noremap <A-h> <C-w>h
  " in terminal mode (neovim specific)
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  nnoremap H :tabprevious<CR>
  nnoremap L :tabnext<CR>

  " close buffer
  noremap <leader>c :bd!<CR>

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

  nnoremap <silent> <leader><SPace> :nohlsearch<cr>

  " autocomplete
  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <S-Tab> <c-n>

  " copy buffer path to clipboard
  nmap cp :silent !echo '%:p' \| pbcopy<CR>

  nmap <leader>w "zyiw:exe "F ".@z.""<CR>

  " FZF (Fizzy Finder)
  nmap <leader>f :Files<CR>
  nmap <leader>s :BLines<CR>

  " open terminal in current buffer
  nmap <leader>t :edit term://fish<CR>

  " exit from terminal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-r> <C-\><C-n>
" }}}

" View {{{
  syntax enable

  let base16colorspace=256
  set background=dark
  color base16-oceanicnext
  " color base16-solarized-light

  set ruler       " show the cursor position all the time
  set cursorline  " color current line
  set list        " show invisible characters

  " wrap long lines
  set wrap
  set showbreak=↪\

  " display extra whitespace
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

  set colorcolumn=100

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

  " let g:rg_command = '
  " \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  " \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  " \ -g "!{.git,node_modules,vendor}/*" '

  " command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

  " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
  command! -bang -nargs=* F
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  " Likewise, Files command with preview window
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" }}}

" Functions {{{
  function! <SID>StripTrailingWhitespaces()
    if exists('b:noStripWhiteSpaces')
      return
    endif

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
    autocmd BufWritePre *.sql let b:noStripWhiteSpaces=1
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

    " arbre (https://github.com/activeadmin/arbre) processing
    autocmd BufEnter *.arb setlocal filetype=ruby

    autocmd BufLeave * set norelativenumber number
    autocmd BufEnter * set relativenumber

    autocmd Filetype gitcommit setlocal textwidth=72
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
  augroup END
" }}}

" NeoVim Specific {{{
  set termguicolors

  " Disable vim auto visual mode using mouse
  set mouse-=a

  " # Increase maximum amount of memory (in Kbyte) to use for pattern matching.
  set maxmempattern=20000
" }}}

" vim:foldmethod=marker:foldlevel=0:foldminlines=1
