" vim:foldmethod=marker:foldminlines=1

" Common settings {{{

  syntax enable
  filetype plugin indent on

  let mapleader=','

  set nocompatible
  set shell=/bin/bash
  set exrc
  set secure
  set modelines=1

  " ALWAYS use the clipboard for ALL operations
  set clipboard+=unnamedplus

  " This enables us to undo files even if you exit Vim.
  if has('persistent_undo')
    set undofile
    set undodir=~/tmp/nvim/undo/
  endif

  " Buffer should still exist if window is closed
  set hidden

  set updatetime=300

  " Automatically read changed files
  set autoread

  set autowriteall
  set foldmethod=indent
  set foldlevel=20

  set autoindent
  set smartindent

  " Always show statusline
  set laststatus=2

  set colorcolumn=100

  " Increase maximum amount of memory (in Kbyte) to use for pattern matching.
  set maxmempattern=20000

  set noswapfile " Don't use swapfile
  set nobackup   " Don't create annoying backup files

  " Tabs
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set shiftround
  set expandtab

  set backspace=indent,eol,start  " Makes backspace key more powerful.

  set termguicolors

  " Indicate fast terminal conn for faster redraw
  set ttyfast

  " Disable vim auto visual mode using mouse
  set mouse-=a

  set ruler       " show the cursor position all the time
  set cursorline  " color current line
  set list        " show invisible characters

  " wrap long lines
  set wrap
  set showbreak=↪\

  " display extra whitespace
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

  set colorcolumn=100
  set numberwidth=5

  " have some context around the current line always on screen
  set scrolloff=3

  " show (partial) command in the last line of the screen
  set showcmd

  " autocomplete
  set wildmode=list:longest,list:full

  " visual autocomplete for command menu
  set wildmenu

  " Don't pass messages to ins-completion-menu
  set shortmess+=c

  " Execute normal mode commands in Russian keyboard
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

  set signcolumn=yes

  set ignorecase
  set smartcase
  set incsearch
  set hlsearch  " Enable search highlighting,
  nohlsearch    " but do not highlight last search on startup
" }}}

" Apply local settings {{{
  if filereadable('.nvimrc')
    source .nvimrc
  endif
" }}}

" Plugins {{{

  let g:plug_window='new'

  let s:plugs_path='~/.local/share/nvim/plugged'
  call plug#begin(s:plugs_path)

  " must have
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'
  Plug '907th/vim-auto-save'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'easymotion/vim-easymotion'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'janko-m/vim-test'
  Plug 'jiangmiao/auto-pairs'
  Plug 'DataWraith/auto_mkdir'

  " languages
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " frontend
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'mattn/emmet-vim'
  Plug 'peitalin/vim-jsx-typescript'

  " appearance
  Plug 'chriskempson/base16-vim'
  Plug 'junegunn/goyo.vim'
  " Plug 'psliwka/vim-smoothie'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'

  " lint engine
  Plug 'w0rp/ale'
  " LSP
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " snippets manager
  Plug 'SirVer/ultisnips'

  " syntax and indentations
  Plug 'hallison/vim-rdoc'
  Plug 'sheerun/vim-polyglot'

  " others
  Plug 'VincentCordobes/vim-translate'
  Plug 'gcmt/taboo.vim'
  Plug 'preservim/tagbar'
  Plug 'knsh14/vim-github-link'

  " disable vimwiki by default
  if !exists('g:vimwiki_enabled')
    let g:loaded_vimwiki = 1
  endif
  Plug 'vimwiki/vimwiki'

  call plug#end()

" }}}

" Plugins Settings {{{

  " vim-github-link {{
    nnoremap gcp :GetCommitLink<CR>
  " }}

  " emmet {{{
    let g:user_emmet_leader_key='<C-r>'
  " }}}

  " vimwiki {{{
    let g:vimwiki_list = [{
          \ 'path': '~/Dropbox/wiki/',
          \ 'syntax': 'markdown',
          \ 'ext': '.md',
          \ }]
  " }}}

  " airline {{{
    let g:airline_theme='base16_oceanicnext'
  " }}}

  " autopairs {{{
    augroup AutoPairs
      autocmd!
      " NOTE: let g:AutoPairs['|']='|' doesn't work
      " see https://github.com/jiangmiao/auto-pairs/issues/213
      autocmd FileType ruby let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''", "`":"`", "|":"|"}
    augroup END
  " }}}

  " vim-ruby {{{
    let ruby_no_expensive = 1
  " }}}

  " autosave {{{
    let g:auto_save = 1
  " }}}

  " fugitive {{{
    if !exists('s:git_status_line_added')
      set statusline+=%{fugitive#statusline()}
      let s:git_status_line_added=1
    endif

    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <Leader>gb :Git blame<CR>
    nnoremap <Leader>gd :Gdiff<CR>
    nnoremap <leader>gg "zyiw:exe "Ggrep ".@z.""<CR>
  " }}}

  " nerdtree {{{
    let NERDTreeShowHidden=1
    let g:NERDTreeWinSize=40

    nnoremap <silent> <Leader>e :NERDTreeFind<CR>
    nnoremap <silent> <C-e> :NERDTreeToggle<CR>
  " }}}

  " easy align {{{
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  " }}}

  " vim tests {{{
    nnoremap <silent> <leader>r :TestNearest<CR>
    nnoremap <silent> <leader>ar :TestFile<CR>
    nnoremap <silent> <leader>lt :TestVisit<CR>

    let test#strategy = "neovim"
    let test#ruby#rspec#executable = 'bundle exec rspec'
    let test#ruby#bundle_exec = 0
  " }}}

  " ale {{{
    let g:ale_enabled = 0
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
    let g:ale_disable_lsp = 1
    let g:ale_linters_explicit = 1

    let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
    let g:ale_ruby_rubocop_auto_correct_all = 1

    let g:ale_linters = {
    \   'ruby': ['rubocop'],
    \   'json': ['fixjson'],
    \   'go': [],
    \}

    let g:ale_fixers = {
    \   'ruby': ['rubocop'],
    \   'json': ['fixjson'],
    \   'go': [],
    \}

    nnoremap <silent> fix :ALEFix<CR>
    nnoremap <silent> ]a :ALENextWrap<CR>
    nnoremap <silent> [a :ALEPreviousWrap<CR>
    nnoremap <leader>at :ALEToggle<CR>
  " }}}

  " vim go {{{
    let g:go_fmt_autosave = 0
    let g:go_fmt_command = 'goimports'
    let g:go_list_type = 'quickfix'
    let g:go_fmt_fail_silently = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_build_constraints = 1
    let g:go_term_enabled = 1
    let g:go_term_mode = 'silent keepalt rightbelow vsplit'

    " run :GoBuild or :GoTestCompile based on the go file
    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction

    augroup Go
      autocmd!
      autocmd FileType go nmap <silent> gob :<C-u>call <SID>build_go_files()<CR>
      autocmd FileType go nmap gor <Plug>(go-run)
      autocmd FileType go nmap goc <Plug>(go-coverage-toggle)
      autocmd FileType go nmap got <Plug>(go-test)
      autocmd FileType go nmap fix <Plug>(go-imports)
      autocmd FileType go nmap <Leader>i <Plug>(go-info)
      autocmd BufNewFile,BufRead *.go,*.mod setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
      autocmd BufNewFile,BufRead *.go,*.mod set nolist
    augroup END
  " }}}

  " ultisnips {{{
    let g:UltiSnipsExpandTrigger='<c-o>'
    let g:UltiSnipsJumpForwardTrigger='<c-o>'
    let g:UltiSnipsJumpBackwardTrigger='<c-b>'
    let g:UltiSnipsListSnippets='<c-l>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/snips']
    let g:UltiSnipsEditSplit='vertical'
    nnoremap <Leader>us :UltiSnipsEdit<CR>
  " }}}

  " goyo {{{
    nnoremap <Leader>go :Goyo<CR>
    let g:goyo_width = 100

    autocmd! User GoyoEnter nested call <SID>numbers_off()
    autocmd! User GoyoLeave nested call <SID>numbers_on()
  " }}}

  " vim-translate {{{
    let g:translate#default_languages = {
      \ 'ru': 'en',
      \ 'en': 'ru'
      \ }
    vnoremap <silent> <leader>t :TranslateVisual<CR>
  " }}}

  " fzf {{{
    let $FZF_DEFAULT_OPTS =
      \ system('cat $FZF_DEFAULT_OPTS_FILE') . ' --reverse'
    let g:fzf_preview_window = []

    command! -bang -nargs=* F
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always -g "!{node_modules,.git,tmp,vendor,sorbet}" --smart-case -- '.shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview(),
      \   <bang>0
      \ )

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    nnoremap <leader>w "zyiw:exe "F ".@z.""<CR>
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>s :BLines<CR>
    nnoremap <leader>bs :Buffers<CR>
    nnoremap <leader>m :Marks<CR>
    nnoremap <leader>gf :GFiles?<CR>
  " }}}

  " coc {{{
    let g:coc_global_extensions = [
          \ 'coc-json',
          \ 'coc-html',
          \ 'coc-css',
          \ 'coc-tsserver',
          \ ]

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_backspace() ? "\<TAB>" :
          \ coc#refresh()

    function! s:check_backspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    " GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>a <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf <Plug>(coc-fix-current)

    nmap <silent> [d <Plug>(coc-diagnostic-prev)
    nmap <silent> ]d <Plug>(coc-diagnostic-next)

    " Map function and class text objects
    " Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    if !exists('s:coc_status_line_added')
      set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
      let s:coc_status_line_added = 1
    endif

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

  " }}}

  " tagbar {{{
    let g:tagbar_sort = 0 " sort by order in the source file
    nmap <C-m> :TagbarToggle<CR>
  " }}}

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

  function! s:get_selected_text()
    silent! normal! gv"ay
    return @a
  endfunction

  function! s:numbers_on()
    set number
    augroup numbers
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &ft !=# 'nerdtree' && &buftype !=# 'terminal' | setlocal relativenumber | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &ft !=# 'nerdtree' && &buftype !=# 'terminal' | setlocal norelativenumber | endif
    augroup END
  endfunction

  function! s:numbers_off()
    set nonumber norelativenumber
    augroup numbers
      autocmd!
    augroup END
  endfunction

  function OpenPlug(plug) abort
    let without_opts = split(a:plug, ',')[0]
    let normalized_name = substitute(without_opts, "Plug", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let plug_name = split(normalized_name, '/')[-1]
    let path_to_plug = s:plugs_path . '/' . plug_name
    execute('e ' . path_to_plug)
    execute('lcd ' . path_to_plug)
  endfunction

  function OpenGem(gem) abort
    let without_opts = split(a:gem, ',')[0]
    let normalized_name = substitute(without_opts, "gem", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let path_to_gem = system('bundle info --path ' . normalized_name)
    execute('lcd ' . path_to_gem)
    execute('e . ')
  endfunction

  function Conf() abort
    execute 'e '.$MYVIMRC
    execute 'lcd %:p:h'
  endfunction
" }}}

" Commands {{{
  command! Conf call Conf()
" }}}

" Common mappings {{{

  " Navigate by completion list by ctrl-j (down) and ctrl-k (up)
  inoremap <c-j> <c-n>
  inoremap <c-k> <c-p>

  " Act like D and C
  nnoremap Y y$

  " fast exit to normal mode
  inoremap jk <esc>
  vnoremap <C-c> <esc>

  " space open/closes folds
  nnoremap <space> za

  " switching windows
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  nnoremap <C-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l
  nnoremap <A-h> <C-w>h
  " in terminal mode (neovim specific)
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  nnoremap <silent>H :tabprevious<CR>
  nnoremap <silent>L :tabnext<CR>

  " close buffer
  nnoremap <leader>c :bd!<CR>

  " vmap for maintain Visual Mode after shifting > and <
  vnoremap < <gv
  vnoremap > >gv

  " split
  nnoremap <Leader>h :split<CR><C-w>j
  nnoremap <Leader>v :vsplit<CR><C-w>w

  " move visual block
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " move to beginning/end of line
  nnoremap B ^
  nnoremap E g_
  vnoremap B ^
  vnoremap E g_

  nnoremap <silent> <leader><SPace> :nohlsearch<cr>

  " copy buffer path to clipboard
  nnoremap cp :let @+=expand('%')<CR>
  " copy buffer absolute path to clipboard
  nnoremap cpa :let @+=expand('%:p')<CR>
  " copy buffer path with line number to clipboard
  nnoremap cpn :let @+=printf('%s:%d', expand('%'), expand(line('.')))<CR>

  " open terminal in current buffer
  nnoremap <leader>t :term fish<CR>

  " source config
  nnoremap S :source $MYVIMRC<CR>

  " exit from terminal mode
  tnoremap jk <C-\><C-n>

  nnoremap <silent> <C-n> :cnext<CR>
  nnoremap <silent> <C-p> :cprevious<CR>
" }}}

" Autogroups {{{

  " Common {{{
    augroup common
      autocmd!

      " Strip trailing whitespaces
      autocmd BufWritePre *.sql let b:noStripWhiteSpaces=1
      autocmd BufWritePre * :call <SID>strip_trailing_whitespaces()

      autocmd FileType gitcommit setlocal colorcolumn=80
      autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

      " Allow to open source code of selected plugin in new tab
      autocmd FileType vim nnoremap <silent> <leader>o :normal vil<CR> :call
        \ OpenPlug(<SID>get_selected_text())<CR>

      autocmd FileType nerdtree silent execute 'normal R'
      autocmd FileType nerdtree setlocal nonumber norelativenumber

      autocmd TermOpen * setlocal nonumber norelativenumber
    augroup END
  " }}}

  " ruby {{{
    augroup ruby
      autocmd!
      autocmd FileType ruby compiler ruby
      autocmd Filetype ruby set keywordprg=ri\ -f\ rdoc

      " Allow to open source code of selected gem in new tab
      autocmd FileType ruby nnoremap <silent> <leader>bo :normal vil<CR> :call
        \ OpenGem(<SID>get_selected_text())<CR>

      " Expose command Bo to open source code of a gem
      " Example of usage:
      "   :Bo activerecord
      autocmd Filetype ruby command! -nargs=1 Bo call OpenGem(<q-args>)

      " Support arbre (https://github.com/activeadmin/arbre)
      autocmd BufEnter *.arb setlocal filetype=ruby
    augroup END
  " }}}

  " javascript {{{
    augroup js
      autocmd!
      autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
      autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
      autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    augroup END
  " }}}
" }}}

" Setup colorscheme {{{

  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif

" }}}

:call <SID>numbers_on()
