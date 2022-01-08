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

  " Automatically read changed files
  set autoread

  set autowriteall

  set foldmethod=indent
  set foldlevel=20

  set autoindent
  set smartindent

  set laststatus=2 " always show statusline

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

  set mouse=a

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
  set relativenumber
  set number

  " have some context around the current line always on screen
  set scrolloff=3

  " show (partial) command in the last line of the screen
  set showcmd

  set wildmenu
  set wildmode=list:longest,list:full

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
  if filereadable('.nvimrc_before_plugs')
    source .nvimrc_before_plugs
  endif
" }}}

" Plugins {{{
  let g:plug_window='new'

  let s:plugs_path='~/.local/share/nvim/plugged'
  call plug#begin(s:plugs_path)

  " must have
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf'
  Plug 'janko-m/vim-test'
  Plug 'phaazon/hop.nvim'   " easymotion for neovim
  Plug 'tpope/vim-surround' " delete/change/add parentheses/quotes/tags
  Plug 'b3nj5m1n/kommentary'
  Plug 'junegunn/vim-easy-align'

  " interface to git
  Plug 'tpope/vim-fugitive'

  " manage terminal windows
  Plug 'akinsho/toggleterm.nvim'
  Plug 'kassio/neoterm' " for vim-test

  " Snippets manager
  Plug 'SirVer/ultisnips'

  " autocompletion
  Plug 'vim-denops/denops.vim'
  Plug 'Shougo/ddc.vim'
  Plug 'Shougo/ddc-around'
  Plug 'Shougo/ddc-matcher_head'
  Plug 'Shougo/ddc-sorter_rank'
  Plug 'tani/ddc-fuzzy'
  Plug 'matsui54/ddc-ultisnips'
  Plug 'matsui54/ddc-buffer'
  Plug 'delphinus/ddc-treesitter'
  Plug 'Shougo/ddc-nvim-lsp'

  " lsp
  Plug 'neovim/nvim-lspconfig'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " appearance
  Plug 'chriskempson/base16-vim'
  Plug 'folke/zen-mode.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'

  " syntax and indentations
  Plug 'hallison/vim-rdoc'
  Plug 'sheerun/vim-polyglot'

  " working with text objects
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " others
  Plug 'nvim-lua/plenary.nvim'  " general utils
  Plug 'windwp/nvim-autopairs'
  Plug 'preservim/nerdtree'
  Plug 'knsh14/vim-github-link'
  Plug 'Pocco81/AutoSave.nvim'
  Plug 'DataWraith/auto_mkdir'
  Plug 'dense-analysis/ale'
  Plug 'jsfaint/gen_tags.vim'

  " disable vimwiki by default
  if !exists('g:vimwiki_enabled')
    let g:loaded_vimwiki = 1
  endif
  Plug 'vimwiki/vimwiki'

  call plug#end()

  " Clear all default mappings which comes from plugins
  if !exists('g:mapclear')
    let g:mapclear = 1
    mapclear
  endif
" }}}

" Plugins Settings {{{
  " nerdtree {{{
    let NERDTreeShowHidden=1
    let NERDTreeWinSize = 45
    nnoremap <silent> <C-e> :NERDTreeToggle<CR>
    nnoremap <silent> <Leader>e :NERDTreeFind<CR>
  " }}}

  " autocompletion (via ddc plugin) {{{
    set completeopt=menuone,noselect
    set shortmess+=c " don't pass messages to ins-completion-menu

    call ddc#custom#patch_global('sources', ['around', 'ultisnips', 'buffer', 'treesitter', 'nvim-lsp'])

    call ddc#custom#patch_global('sourceOptions', {
      \   'ultisnips': {'mark': 'US'},
      \   'around': {'mark': 'A'},
      \   'buffer': {'mark': 'B'},
      \   'treesitter': {'mark': 'T'},
      \   'nvim-lsp': {'mark': 'LSP', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'},
      \   '_': {
      \     'ignoreCase': v:true,
      \     'matchers': ['matcher_fuzzy'],
      \     'sorters': ['sorter_fuzzy'],
      \     'converters': ['converter_fuzzy']
      \   }
      \ })

    call ddc#custom#patch_global('sourceParams', {
      \ 'buffer': {
      \   'requireSameFiletype': v:false,
      \   'fromAltBuf': v:true,
      \   'forceCollect': v:true,
      \ },
      \ })

    call ddc#custom#patch_global('filterParams', {
      \   'matcher_fuzzy': {
      \     'splitMode': 'character'
      \   }
      \ })

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()

    inoremap <silent><expr> <C-j> pumvisible() ? '<C-n>' : '<Down>'
    inoremap <silent><expr> <C-k> pumvisible() ? '<C-p>' : '<Up>'

    call ddc#enable()
  " }}}

  " gen_tags {{{
    let g:loaded_gentags#gtags = 1
    let g:gen_tags#blacklist = ['spec']
    let g:gen_tags#ctags_opts = '--languages=ruby'
  " }}}

  " ale {{{
    let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 0
    " let g:ale_open_list = 1
    let g:ale_linters = {'ruby': ['rubocop']}
    let g:ale_linters_explicit = 1
    let g:ale_fixers = {'ruby': ['rubocop']}
    let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
    let g:ale_ruby_rubocop_auto_correct_all = 1
    " let g:ale_sign_error = ''
    " let g:ale_sign_warning = ''
    " let g:ale_virtualtext_cursor = 1
    " let g:ale_virtualtext_prefix = '► '
    let g:ale_enabled = 0

    function! SetupAleDiagnosticHighlight() abort
      let guibg_linenr = synIDattr(synIDtrans(hlID('LineNr')), 'bg', 'gui')
      exec printf("highlight ALEErrorSign guibg=%s guifg=#FF0000 gui=bold", guibg_linenr)
      exec printf("highlight ALEWarningSign guibg=%s guifg=#FFA500 gui=bold", guibg_linenr)
    endfunction

    nnoremap <silent> <Leader>af :ALEFix<CR>

    augroup Ale
      autocmd!
      autocmd User ALELintPre call SetupAleDiagnosticHighlight()
    augroup END

    call SetupAleDiagnosticHighlight()
  " }}}

  " ultisnips {{{
    let g:UltiSnipsExpandTrigger='<c-o>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
    let g:UltiSnipsListSnippets='<c-l>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/snips']
    let g:UltiSnipsEditSplit='vertical'
  " }}}

  " fugitive {{{
    nnoremap <Leader>gs :Git<CR>
    nnoremap <Leader>gb :Git blame<CR>
    nnoremap <Leader>gd :Gdiff<CR>
  " }}}

    lua require('kommentary.config').use_default_mappings()

    lua require('configs/toggleterm')
    lua require('configs/treesitter')
    lua require('configs/hop')
    lua require('configs/autopairs')
    lua require('configs/autosave')
    lua require('configs/textobjects')

  " lsp {{{
    function! SetupLspDiagnosticHighlight() abort
      let guibg_linenr = synIDattr(synIDtrans(hlID('LineNr')), 'bg', 'gui')
      exec printf("highlight DiagnosticSignError guibg=%s guifg=#FF0000 gui=bold", guibg_linenr)
      exec printf("highlight DiagnosticSignWarn guibg=%s guifg=#FFA500 gui=bold", guibg_linenr)
      exec printf("highlight DiagnosticSignInfo guibg=%s guifg=None gui=bold", guibg_linenr)
      exec printf("highlight DiagnosticSignHint guibg=%s guifg=#0000FF gui=bold", guibg_linenr)
    endfunction

    lua require('configs/lsp')

    call SetupLspDiagnosticHighlight()
  " }}}

  " zen-mode {{{
    lua require("configs/zenmode")
    nnoremap <silent> <Leader>go :ZenMode<CR>
  " }}}

  " indent-blankline {{{
    lua require('configs/indent-blankline')
    let g:indent_blankline_enabled = v:false
    nnoremap <leader>it :IndentBlanklineToggle<CR>
  " }}}

  " vim-github-link {{{
    nnoremap gcp :GetCommitLink<CR>
  " }}}

  " vimwiki {{{
    let g:vimwiki_list = [{
          \ 'path': '~/Dropbox/wiki/',
          \ 'syntax': 'markdown',
          \ 'ext': '.md',
          \ }]
  " }}}

  " neoterm {{{
    let g:neoterm_shell='fish'
    let g:neoterm_automap_keys = v:false
    let g:neoterm_default_mod = 'botright'
  " }}}

  " easy align {{{
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  " }}}

  " vim tests {{{
    function! NeotermCustom(cmd)
      exec 'T clear'
      exec 'T ' . a:cmd
      Topen
    endfunction

    let g:test#custom_strategies = { 'neoterm_custom': function('NeotermCustom') }
    let g:test#strategy = 'neoterm_custom'
    let test#ruby#rspec#executable = 'bundle exec rspec'
    let test#ruby#bundle_exec = 0

    nnoremap <silent> <leader>r :TestNearest<CR>
    nnoremap <silent> <leader>ar :TestFile<CR>
    nnoremap <silent> <leader>lt :TestVisit<CR>
  " }}}

  " vim-translate {{{
    let g:translate#default_languages = {
      \ 'ru': 'en',
      \ 'en': 'ru'
      \ }
    vnoremap <silent> <leader>t :TranslateVisual<CR>
  " }}}

  " fzf {{{
    if filereadable($FZF_DEFAULT_OPTS_FILE)
      let $FZF_DEFAULT_OPTS = system('cat $FZF_DEFAULT_OPTS_FILE')
    end

    let g:fzf_preview_window = []

    if exists('g:fzf_ignore_list')
      let $FZF_IGNORE_LIST = g:fzf_ignore_list
    else
      let g:fzf_ignore_list = $FZF_IGNORE_LIST
    endif

    let $FZF_IGNORE_LIST_FOR_GIT_GREP = ':^'..join(split(g:fzf_ignore_list, ','), ' :^')

    command! -bang -nargs=* F
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always -g "!{' . g:fzf_ignore_list . '}" --smart-case -- '.shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview(),
      \   <bang>0
      \ )

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    nnoremap <leader>fw "zyiw:exe "F ".@z.""<CR>
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fh :History<CR>
    nnoremap <leader>fl :BLines<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>fm :Marks<CR>
    nnoremap <leader>fx :Windows<CR>
    nnoremap <leader>fc :Commands<CR>
    nnoremap <leader>gw "zyiw:exe "Gf ".@z.""<CR>
    nnoremap <leader>gf :GFiles?<CR>
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

  function! OpenPlug(plug) abort
    let without_opts = split(a:plug, ',')[0]
    let normalized_name = substitute(without_opts, "Plug", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let plug_name = split(normalized_name, '/')[-1]
    let path_to_plug = s:plugs_path . '/' . plug_name
    execute('lcd ' . path_to_plug)
    execute('e ' . path_to_plug)
  endfunction

  function! OpenGem(gem) abort
    let without_opts = split(a:gem, ',')[0]
    let normalized_name = substitute(without_opts, "gem", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let path_to_gem = system('bundle info --path ' . normalized_name)
    execute('lcd ' . path_to_gem)
    execute('e . ')
  endfunction

  function! Conf() abort
    execute 'tabe '.$MYVIMRC
    execute 'lcd %:p:h'
  endfunction

  function! Confl() abort
    execute 'tabe .nvimrc | split | e .nvimrc_before_plugs'
  endfunction

  function! SourceIfExists(file) abort
    if filereadable(expand(a:file))
      execute 'source' a:file
    endif
  endfunction
" }}}

" Commands {{{
  command! Conf call Conf()
  command! Confl call Confl()
  command! Bd %bd!|e#
  command! -nargs=+ Gf execute 'silent Ggrep' <q-args> $FZF_IGNORE_LIST_FOR_GIT_GREP . ' | copen'
" }}}

" Common mappings {{{
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

  nnoremap <silent>H :tabprevious<CR>
  nnoremap <silent>L :tabnext<CR>

  " close buffer
  nnoremap <leader>k :bd!<CR>
  nnoremap <leader>c <C-w>c

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
  nnoremap cpl :let @+=expand('%')<CR>
  " copy buffer absolute path to clipboard
  nnoremap cpa :let @+=expand('%:p')<CR>
  " copy buffer path with line number to clipboard
  nnoremap cpn :let @+=printf('%s:%d', expand('%'), expand(line('.')))<CR>

  " open terminal in current buffer
  nnoremap <leader>t :term fish<CR>

  " source configs
  nnoremap <silent> S :source $MYVIMRC \| call SourceIfExists(".nvimrc")<CR>

  " exit from terminal mode
  tnoremap jk <C-\><C-n>

  " quickfix navigation
  nnoremap <silent> <C-n> :cnext<CR>
  nnoremap <silent> <C-p> :cprevious<CR>

  " locklist navigation
  nnoremap <silent> ]w :lnext<CR>
  nnoremap <silent> [w :lprevious<CR>

  nnoremap <silent> <leader>nt :tabe<CR>
  nnoremap <leader>w :wa<CR>
  nnoremap <leader>x :xa<CR>

  nnoremap * :keepjumps normal! mi*`i<CR>
" }}}

" Autogroups {{{
    augroup Common
      autocmd!

      " Strip trailing whitespaces
      autocmd BufWritePre *.sql let b:noStripWhiteSpaces=1
      autocmd BufWritePre * :call <SID>strip_trailing_whitespaces()

      autocmd FileType gitcommit setlocal colorcolumn=80
      autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

      " Allow to open source code of selected plugin in new tab
      autocmd FileType vim nmap <buffer> <leader>o :normal vil<CR> :call
        \ OpenPlug(<SID>get_selected_text())<CR>

      autocmd TermOpen * setlocal nonumber norelativenumber

      autocmd TextYankPost * silent! lua vim.highlight.on_yank{timeout=150, on_visual=false}
    augroup END

    augroup Ruby
      autocmd!
      autocmd FileType ruby compiler ruby
      autocmd Filetype ruby set keywordprg=ri\ -f\ rdoc

      " Allow to open source code of selected gem in new tab
      autocmd FileType ruby nmap <buffer> <leader>o :normal vil<CR> :call
        \ OpenGem(<SID>get_selected_text())<CR>

      " Expose command Bo to open source code of a gem
      " Example of usage:
      "   :Bo activerecord
      autocmd Filetype ruby command! -nargs=1 Bo call OpenGem(<q-args>)

      " Support arbre (https://github.com/activeadmin/arbre)
      autocmd BufEnter *.arb setlocal filetype=ruby
      " Support jbuilder
      autocmd BufEnter *.jbuilder setlocal filetype=ruby
      " Support sorbet rbi
      autocmd BufEnter *.rbi setlocal filetype=ruby
    augroup END

    augroup JS
      autocmd!
      autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
      autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
      autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    augroup END
" }}}

" Setup colorscheme {{{
  " `~/.vimrc_background` is touched by chriskempson/base16-shell
  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif
" }}}
