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
  set foldmethod=indent

  " Swap and Backups {{{
    set updatecount=0
    set noswapfile
    set nobackup
    set nowritebackup
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
  Plug 'junegunn/vim-easy-align'
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
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'SirVer/ultisnips'
  Plug 'junegunn/goyo.vim'
  Plug 'posva/vim-vue'
  Plug 'elixir-editors/vim-elixir'
  Plug 'iamcco/markdown-preview.vim'

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

    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gb :Gblame<CR>
    noremap <Leader>gd :Gdiff<CR>
  " }}}

  " netrw {{{
    let g:netrw_preview=1
    let g:netrw_alto=0
  " }}}

  " NerdTREE {{{
    let NERDTreeShowHidden=1
    let g:NERDTreeWinSize=40

    noremap <Leader>e :NERDTreeFind<CR>
    noremap <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
  " }}}

  " Easy Align {{{
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  " }}}

  " Vim Tests {{{
    nmap <silent> <leader>r :TestNearest<CR>
    nmap <silent> <leader>ar :TestFile<CR>

    let test#strategy = "neovim"
    let test#ruby#rspec#executable = 'env USE_SPRING=1 bin/rspec'
  " }}}

  " Ale {{{
    " Configure Ale (installed in ~/.local/share/nvim/site/pack/git-plugins/start/ale)
    packloadall
    silent! helptags ALL

    let g:ale_linters = {
    \   'ruby': ['rubocop'],
    \   'go': [],
    \   'json': ['fixjson'],
    \}

    let g:ale_fixers = {
    \   'ruby': ['rubocop'],
    \   'json': ['fixjson'],
    \}

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_enabled = 0 " disabled by default

    nmap aled <Plug>(ale_disable)
    nmap ale <Plug>(ale_enable)
    nmap fix <Plug>(ale_fix)
    nmap <silent> <C-n> <Plug>(ale_next_wrap)
    nmap <silent> <C-p> <Plug>(ale_previous_wrap)
  " }}}

  " Fizy Finder {{{
    nmap <leader>w "zyiw:exe "F ".@z.""<CR>
    nmap <leader>f :Files<CR>
    nmap <leader>s :BLines<CR>
    nmap <leader>b :Buffers<CR>
    nmap <leader>gf :GFiles?<CR>
    imap <C-f> <plug>(fzf-complete-line)
  " }}}

  " Vim Go {{{
    let g:go_fmt_autosave = 0
    let g:go_fmt_command = 'goimports'
    let g:go_list_type = 'quickfix'
    let g:go_fmt_fail_silently = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
  " }}}

  " Ultisnips {{{
    let g:UltiSnipsJumpForwardTrigger='<c-n>'
    let g:UltiSnipsExpandTrigger='<c-n>'
    let g:UltiSnipsJumpBackwardTrigger='<c-b>'
  " }}}

  " Goyo {{{
    nmap <Leader>go :Goyo<CR>
    let g:goyo_width = 100
  " }}}

" }}}

" Shortcuts {{{

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

  " close all buffer
  noremap <leader>bdbd :bufdo: bd!<CR>

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
  nmap cp :let @+=expand('%')<CR>
  " copy buffer path with line number to clipboard
  nmap cpn :let @+=printf('%s:%d', expand('%'), expand(line('.')))<CR>

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
  color base16-eighties

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

  " To use ripgrep instead of ag:
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
    autocmd BufRead * normal zR

    autocmd Filetype gitcommit setlocal textwidth=72
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

    " go {{{
      autocmd FileType go nmap gob <Plug>(go-build)
      autocmd FileType go nmap gor <Plug>(go-run)
      autocmd FileType go nmap fix <Plug>(go-imports)
      autocmd FileType go nmap <Leader>i <Plug>(go-info)
      autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
      autocmd BufNewFile,BufRead *.go set nolist
    " }}}
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
