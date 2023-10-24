" vim:foldmethod=marker:foldminlines=1

" Plugins {{{
  let g:plug_window='new'

  let s:plugs_path='~/.local/share/nvim/plugged'
  call plug#begin(s:plugs_path)

  " must have
  Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'janko-m/vim-test'
  Plug 'phaazon/hop.nvim'   " easymotion for neovim
  Plug 'tpope/vim-surround' " delete/change/add parentheses/quotes/tags
  Plug 'b3nj5m1n/kommentary'
  Plug 'junegunn/vim-easy-align'

  " interface to git
  Plug 'tpope/vim-fugitive'

  " terminal manager for vim-test
  Plug 'kassio/neoterm'

  " snippets manager
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}

  " lsp
  Plug 'neovim/nvim-lspconfig'

  " treesitter-related staff
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'mfussenegger/nvim-treehopper'

  " framework for defining text objects, see https://github.com/kana/vim-textobj-user/wiki
  Plug 'kana/vim-textobj-user'
  " al/il for the current line
  Plug 'kana/vim-textobj-line'

  " appearance
  Plug 'chriskempson/base16-vim'

  " general utils
  Plug 'nvim-lua/plenary.nvim'

  " file system explorer
  Plug 'preservim/nerdtree'

  " generate github links
  Plug 'knsh14/vim-github-link'

  " manage tag files
  Plug 'ludovicchabant/vim-gutentags'

  Plug 'DataWraith/auto_mkdir'
  Plug 'dense-analysis/ale'

  Plug 'vimwiki/vimwiki'

  call plug#end()
" }}}

" Basic settings {{{
  let mapleader=','

  " allows loading local executing local nvimrc
  set exrc
  " disallows the use of :autocmd, shell and write commands in local
  set secure

  " the number of lines that is checked for set commands (example: 'vim:foldmethod=marker')
  set modelines=1

  " ALWAYS use the clipboard for ALL operations
  set clipboard+=unnamedplus

  " This enables us to undo files even if you exit Vim
  set undofile

  set autowriteall

  set foldmethod=indent
  set nofoldenable " disable folding at startup

  " Increase maximum amount of memory (in Kbyte) to use for pattern matching
  set maxmempattern=20000

  set noswapfile " Don't use swapfile
  set nobackup   " Don't create annoying backup files

  " Tabs
  set tabstop=2
  set softtabstop=2
  set expandtab
  set shiftwidth=2
  set shiftround

  " Enables 24-bit RGB color in the Terminal UI
  set termguicolors

  " color current line
  set cursorline

  " show invisible characters
  set list
  " display extra whitespace
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

  set colorcolumn=100

  set numberwidth=5
  set number
  set relativenumber

  set wildmode=list:longest,list:full

  " searching
  set ignorecase
  set smartcase
  nohlsearch    " do not highlight last search on startup

  " Use ripgrep for search instead of grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" }}}

" Plugins Settings {{{
  " require lua modules {{{
    lua require('configs/treesitter')
    lua require("configs/luasnip")
  " }}}

  " hop {{{
    lua require('hop').setup { keys = 'etovxpdygfblzhckisuran', quit_key = 'q', term_seq_bias = 0.5 }
  " }}}

  " kommentary {{{
    lua require('kommentary.config').use_default_mappings()
  " }}}

  " gutentags {{{
    let g:gutentags_ctags_exclude = ['*.js', '*.html', '*.erb', '*.rbi', '*.xml', '*.json', '*.ts']
  " }}}

  " nerdtree {{{
    let NERDTreeShowHidden=1
    let NERDTreeWinSize = 45
  " }}}

  " ale (used for ruby only, disabled by default) {{{
    let g:ale_enabled = 0
    let g:ale_virtualtext_cursor = 0
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 0
    let g:ale_linters = {'ruby': ['rubocop']}
    let g:ale_linters_explicit = 1
    let g:ale_fixers = {'ruby': ['rubocop']}
    let g:ale_sign_warning = 'W'
    let g:ale_sign_error = 'E'
    let g:ale_sign_info = 'I'
    " let g:ale_ruby_rubocop_options = '--server --disable-pending-cops'
    " let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
    let g:ale_ruby_rubocop_auto_correct_all = 1

    function! SetupAleDiagnosticHighlight() abort
      let guibg_linenr = synIDattr(synIDtrans(hlID('LineNr')), 'bg', 'gui')
      exec printf("highlight ALEErrorSign guibg=%s guifg=#FF0000 gui=bold", guibg_linenr)
      exec printf("highlight ALEWarningSign guibg=%s guifg=#FFA500 gui=bold", guibg_linenr)
    endfunction

    augroup Ale
      autocmd!
      autocmd User ALELintPre call SetupAleDiagnosticHighlight()
    augroup END

    call SetupAleDiagnosticHighlight()
  " }}}

  " vimwiki {{{
    let g:vimwiki_key_mappings = { 'all_maps': 0 }
    let g:vimwiki_global_ext = 0
    let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.md' }]

    augroup VimWikiLocal
      autocmd!
      autocmd FileType vimwiki set colorcolumn=0|set linebreak|set noexpandtab|set nolist
    augroup END

    " Settings for a local wiki:
    "
    " let g:vimwiki_key_mappings = { 'all_maps': 1 }
    " let g:vimwiki_global_ext = 1
  " }}}

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

  " neoterm {{{
    let g:neoterm_shell='NEOVIM_TERM=1 fish'
    let g:neoterm_automap_keys = v:false
    let g:neoterm_default_mod = 'botright'
  " }}}

  " vim tests {{{
    function! NeotermCustom(cmd)
      exec 'T clear'
      exec 'T ' . a:cmd
      Topen
    endfunction

    let g:test#custom_strategies = { 'neoterm_custom': function('NeotermCustom') }
    let g:test#strategy = 'neoterm_custom'
    let test#ruby#rspec#executable = 'bundle exec rspec --format documentation'
    let test#ruby#bundle_exec = 0
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
  " }}}
" }}}

" Functions {{{
  function! s:strip_trailing_whitespaces() " {{{
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
  endfunction " }}}

  function! s:get_selected_text() " {{{
    silent! normal! gv"ay
    return @a
  endfunction " }}}

  function! FOpenPlug(plug) abort " {{{
    let without_opts = split(a:plug, ',')[0]
    let normalized_name = substitute(without_opts, "Plug", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let plug_name = split(normalized_name, '/')[-1]
    let path_to_plug = s:plugs_path . '/' . plug_name
    execute('lcd ' . path_to_plug)
    execute('e ' . path_to_plug)
  endfunction " }}}

  function! FOpenGem(gem) abort " {{{
    let without_opts = split(a:gem, ',')[0]
    let normalized_name = substitute(without_opts, "gem", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let path_to_gem = system('bundle info --path ' . normalized_name)
    execute('lcd ' . path_to_gem)
    execute('e . ')
  endfunction " }}}

  function! FConf() abort " {{{
    execute 'tabe '.$MYVIMRC
    execute 'lcd %:p:h'
  endfunction " }}}

  function! FConfl() abort " {{{
    execute 'tabe .nvimrc'
  endfunction " }}}

  function! FSourceIfExists(file) abort " {{{
    if filereadable(expand(a:file))
      execute 'source' a:file
    endif
  endfunction " }}}

  function! FRubyGoToSpec() abort " {{{
    let current_path = expand('%')
    let spec_path = substitute(current_path, '.rb', '_spec.rb', 'g')
    let spec_path = 'spec/' . substitute(spec_path, 'app/', '', 'g')
    execute('e ' . spec_path)
  endfunction " }}}

  function! FRubyGoFromSpec() abort " {{{
    let spec_path = expand('%')
    let path = substitute(spec_path, '_spec', '', 'g')
    let path = substitute(path, 'spec/', 'app/', 'g')
    execute('e ' . path)
  endfunction " }}}

  function! FGitGrep(pattern) abort " {{{
    execute 'silent Ggrep ' . a:pattern . ' -- ' . $FZF_IGNORE_LIST_FOR_GIT_GREP . ' | copen'
  endfunction " }}}

  function! FGrep(pattern) abort " {{{
    execute 'silent grep!'
            \ . ' --line-number'
            \ . ' --no-heading'
            \ . ' -g "!{' . g:fzf_ignore_list . '}" ' . a:pattern . ' .'
  endfunction " }}}

  function! FSmartGrep(pattern) abort " {{{
    if isdirectory('.git')
      call FGitGrep(a:pattern)
    else
      call FGrep(a:pattern)
    endif
  endfunction " }}}
" }}}

" Commands {{{
  command! Conf call FConf()
  command! Confl call FConfl()
  command! Bd %bd!|e#
  command! -nargs=+ GGrep call FGitGrep(<q-args>)
  command! -nargs=+ FGrep call FGrep(<q-args>)
  command! -nargs=+ Grep call FSmartGrep(<q-args>)
  command! Todo :Grep TODO
  command! LuaSnipEdit :lua require('luasnip.loaders').edit_snippet_files()
" }}}

" Mappings {{{
  " fast exit to normal mode
  inoremap jk <Esc>

  " go to beginning and end
  inoremap <C-b> <Esc>^i
  inoremap <C-e> <Esc>A

  " navigate within insert mode
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-l> <Right>
  inoremap <C-h> <Left>

  " space open/closes folds
  nnoremap <space> za

  " Act like D and C
  nnoremap Y y$

  " Search mappings: These will make it so that going to the
  " next one in a search will center on the line it's found in.
  nnoremap n nzzzv
  nnoremap N Nzzzv
  nnoremap <C-]> <C-]>zzzv

  " switching windows
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  nnoremap <C-h> <C-w>h

  " expand current window
  nnoremap <leader>E <C-w>\|<C-w>_
  nnoremap <leader>R <C-w>=

  " navigate between tabs
  nnoremap <silent>H :tabprevious<CR>
  nnoremap <silent>L :tabnext<CR>

  " close buffer
  nnoremap <leader>k :bd!<CR>
  " close window
  nnoremap <leader>c <C-w>c

  " save changes
  nnoremap <leader>s :w<CR>

  " split
  nnoremap <Leader>h :split<CR><C-w>j
  nnoremap <Leader>v :vsplit<CR><C-w>l

  " move to beginning/end of line
  nnoremap B ^
  nnoremap E g_

  " move to beginning/end of line
  vnoremap B ^
  vnoremap E g_
  vnoremap < <gv
  vnoremap > >gv

  " Turn off higlhlight of searching
  nnoremap <silent> <leader><space> :nohlsearch<cr>

  " copy buffer path to clipboard
  nnoremap cpl :let @+=expand('%')<CR>
  " copy buffer absolute path to clipboard
  nnoremap cpa :let @+=expand('%:p')<CR>
  " copy buffer path with line number to clipboard
  nnoremap cpn :let @+=printf('%s:%d', expand('%'), expand(line('.')))<CR>

  " open terminal in current buffer
  nnoremap <leader>t :term NEOVIM_TERM=1 fish<CR>

  " source configs
  nnoremap <silent> S :source $MYVIMRC \| call FSourceIfExists(".nvimrc")<CR>

  " exit from terminal mode
  tnoremap jk <C-\><C-n>

  " quickfix navigation
  nnoremap <silent> <C-n> :cnext<CR>
  nnoremap <silent> <C-p> :cprevious<CR>

  " open new tab
  nnoremap <silent> <leader>b :tabe<CR>

  " Don't copy the replaced text after pasting in visual mode
  " https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
  xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>

  nnoremap * :keepjumps normal! mi*`i<CR>

  " nerdtree
  nnoremap <silent> <C-e> :NERDTreeToggle<CR>
  nnoremap <silent> <Leader>e :NERDTreeFind<CR>

  " ale (used for ruby only, disabled by default)
  nnoremap <silent> <Leader>af :ALEFix<CR>
  nnoremap <silent> ]e :ALENextWrap<CR>
  nnoremap <silent> [e :ALEPreviousWrap<CR>

  " fugitive
  nnoremap <Leader>gs :Git<CR>
  nnoremap <Leader>gb :Git blame<CR>
  nnoremap <Leader>gd :Gdiff<CR>

  " easy align
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  " vim tests
  nnoremap <silent> <leader>r :TestNearest<CR>
  nnoremap <silent> <leader>ar :TestFile<CR>

  " fzf
  nnoremap <leader>fw "zyiw:exe "F ".@z.""<CR>
  nnoremap <leader>ff :Files<CR>
  nnoremap <leader>fh :History<CR>
  nnoremap <leader>fl :BLines<CR>
  nnoremap <leader>fb :Buffers<CR>
  nnoremap <leader>fm :Marks<CR>
  nnoremap <leader>fx :Windows<CR>
  nnoremap <leader>fc :Commands<CR>
  nnoremap <leader>gw "zyiw:exe "Grep ".@z.""<CR>
  nnoremap <leader>gf :GFiles?<CR>

  " hop
  nnoremap <silent> <leader><leader>w :lua require('hop').hint_words()<CR>
  vnoremap <silent> <leader><leader>w :lua require('hop').hint_words()<CR>
  nnoremap <silent> <leader><leader>l :lua require('hop').hint_lines()<CR>
  vnoremap <silent> <leader><leader>l :lua require('hop').hint_lines()<CR>
  nnoremap <silent> <leader><leader>f :lua require('hop').hint_char1()<CR>
  vnoremap <silent> <leader><leader>f :lua require('hop').hint_char1()<CR>

  " luasnip
  "
  " press <Tab> to expand or jump in a snippet. These can also be mapped separately
  " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
  "
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  " -1 for jumping backwards.
  inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
  snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
  " " For changing choices in choiceNodes (not strictly necessary for a basic setup).
  " imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  " smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

  " treehopper
  omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
  xnoremap <silent> m :lua require('tsht').nodes()<CR>
" }}}

" Autogroups {{{
    augroup General " {{{
      autocmd!
      " Strip trailing whitespaces (except sql)
      autocmd BufWritePre *.sql let b:noStripWhiteSpaces=1
      autocmd BufWritePre * :call <SID>strip_trailing_whitespaces()

      autocmd FileType gitcommit setlocal colorcolumn=80

      " Allow to open source code of selected vim plugin in new tab
      autocmd FileType vim nmap <buffer> <leader>o :normal vil<CR> :call FOpenPlug(<SID>get_selected_text())<CR>

      autocmd TermOpen * setlocal nonumber norelativenumber

      autocmd TextYankPost * silent! lua vim.highlight.on_yank{timeout=150, on_visual=false}

      " Automatically open quickfix and locklist
      autocmd QuickFixCmdPost [^l]* cwindow
      autocmd QuickFixCmdPost l*    lwindow

      autocmd FileType fugitive,fugitiveblame nmap <buffer> q gq
      autocmd FileType lspinfo nmap <buffer> q <Esc>
    augroup END " }}}

    augroup Ruby " {{{
      autocmd!

      autocmd BufNewFile,BufRead *.rb,*.jbuilder,*.arb,*.gemspec setlocal filetype=ruby

      " Allow to open source code of the selected gem in a new tab
      autocmd FileType ruby nmap <buffer> <leader>o :normal vil<CR> :call FOpenGem(<SID>get_selected_text())<CR>

      autocmd Filetype ruby command! -nargs=1 Bo call FOpenGem(<q-args>)
      autocmd FileType ruby command! GoToSpec call FRubyGoToSpec()
      autocmd FileType ruby command! GoFromSpec call FRubyGoFromSpec()

    augroup END " }}}
" }}}

" Setup colorscheme {{{
  " `~/.vimrc_background` is touched by chriskempson/base16-shell
  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif
" }}}
