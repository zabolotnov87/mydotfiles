" Config file for NeoVim
"
" author: Sergey Zabolotnov (sergey.zabolotnov@gmail.com)
"

" Basic {{{
  set nocompatible

  set shell=/bin/bash
  set exrc
  set secure
  set modelines=1

  let mapleader=','

  filetype plugin indent on

  set clipboard=unnamed

  set autoread
  set autowriteall
  set foldmethod=indent

  set colorcolumn=100

  " Swap and Backups {{{
    set updatecount=0
    set noswapfile
    set nobackup
    set nowritebackup
  " }}}

" }}}

" Plugins {{{
  let g:plug_window='new'

  let s:plugs_path='~/.local/share/nvim/plugged'
  call plug#begin(s:plugs_path)

  Plug 'vim-scripts/vim-auto-save'
  Plug 'tpope/vim-commentary'
  " Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/vim-easy-align'
  Plug 'DataWraith/auto_mkdir'
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
  Plug 'w0rp/ale'
  Plug 'VincentCordobes/vim-translate'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'tpope/vim-endwise'

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
    nmap <silent> an <Plug>(ale_next_wrap)
    nmap <silent> ab <Plug>(ale_previous_wrap)
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
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsExpandTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
    let g:UltiSnipsListSnippets='<c-l>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim-snippets']
    let g:UltiSnipsEditSplit='vertical'
    noremap <Leader>us :UltiSnipsEdit<CR>
  " }}}

  " Goyo {{{
    nmap <Leader>go :Goyo<CR>
    let g:goyo_width = 100
  " }}}

  " vim-translate {{{
    let g:translate#default_languages = {
      \ 'ru': 'en',
      \ 'en': 'ru'
      \ }
    vnoremap <silent> <leader>t :TranslateVisual<CR>
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
  noremap <Leader>h :split<CR><C-w>j
  noremap <Leader>v :vsplit<CR><C-w>w

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
  inoremap <Tab> <c-r>=<SID>insert_tab_wrapper()<cr>
  inoremap <S-Tab> <c-n>

  " copy buffer path to clipboard
  nmap cp :let @+=expand('%')<CR>
  " copy buffer absolute path to clipboard
  nmap cpf :let @+=expand('%:p')<CR>
  " copy buffer path with line number to clipboard
  nmap cpn :let @+=printf('%s:%d', expand('%'), expand(line('.')))<CR>

  " open terminal in current buffer
  nmap <leader>t :vsp term://fish<CR>

  " open vim config
  nmap conf :tabnew $MYVIMRC<CR>
  " reload vim config
  nnoremap <silent> so :so $MYVIMRC<CR>:e<CR>

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

  set signcolumn=yes
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
  function! s:strip_trailing_whitespaces()
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

  function! s:insert_tab_wrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
  endfunction

  function! s:open_plug(plug)
    let chars_to_delete = "'\""
    let without_opts = split(a:plug, ',')[0]
    let normalized_name = trim(split(without_opts, '/')[-1], chars_to_delete)
    let path_to_plug = s:plugs_path . '/' . normalized_name
    execute('tabnew ' . path_to_plug)
    execute('lcd ' . path_to_plug)
  endfunction

  function! s:get_selected_text()
    silent! normal! gv"ay
    return @a
  endfunction
" }}}

" Commands {{{
  " Open plugin in new Tab
  command! -bang -nargs=? OpenPlug call <SID>open_plug(<q-args>)
" }}}

" Autogroups {{{
  augroup configgroup
    autocmd!

    " Strip trailing whitespaces
    autocmd BufWritePre *.sql let b:noStripWhiteSpaces=1
    autocmd BufWritePre * :call <SID>strip_trailing_whitespaces()

    " arbre (https://github.com/activeadmin/arbre) processing
    autocmd BufEnter *.arb setlocal filetype=ruby

    " Expand all folds automatically
    autocmd BufRead * normal zR

    autocmd FileType gitcommit setlocal colorcolumn=80
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

    " Allow to open source code of selected plugin in new tab
    autocmd FileType vim vnoremap <silent> <leader>o :call
      \ <SID>open_plug(<SID>get_selected_text())<CR>

    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END

  augroup Go
    autocmd!
    autocmd FileType go nmap gob <Plug>(go-build)
    autocmd FileType go nmap gor <Plug>(go-run)
    autocmd FileType go nmap fix <Plug>(go-imports)
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    autocmd BufNewFile,BufRead *.go,*.mod setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go,*.mod set nolist
  augroup END

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set norelativenumber
  augroup END
" }}}

" NeoVim Specific {{{
  set termguicolors

  " Disable vim auto visual mode using mouse
  set mouse-=a

  " # Increase maximum amount of memory (in Kbyte) to use for pattern matching.
  set maxmempattern=20000
" }}}

source ~/.vimrc.local

" vim:foldmethod=marker:foldminlines=1
