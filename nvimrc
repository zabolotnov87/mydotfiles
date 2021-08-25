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

  " completion settings
  set completeopt=menuone,noselect
  set wildmode=list:longest,list:full
  set wildmenu
  set shortmess+=c " don't pass messages to ins-completion-menu

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
  Plug 'phaazon/hop.nvim'

  " file explorer
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'

  " autocompletion
  Plug 'hrsh7th/nvim-compe'

  " lsp
  Plug 'neovim/nvim-lspconfig'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " frontend
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'mattn/emmet-vim'
  Plug 'peitalin/vim-jsx-typescript'

  " appearance
  Plug 'chriskempson/base16-vim'
  Plug 'junegunn/goyo.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'

  " syntax and indentations
  Plug 'hallison/vim-rdoc'
  Plug 'sheerun/vim-polyglot'

  " others
  Plug 'VincentCordobes/vim-translate'
  Plug 'knsh14/vim-github-link'
  Plug '907th/vim-auto-save'
  Plug 'junegunn/vim-easy-align'
  Plug 'b3nj5m1n/kommentary'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'DataWraith/auto_mkdir'
  Plug 'windwp/nvim-autopairs'

  " disable vimwiki by default
  if !exists('g:vimwiki_enabled')
    let g:loaded_vimwiki = 1
  endif
  Plug 'vimwiki/vimwiki'

  call plug#end()
" }}}

" Plugins Settings {{{
"   nvim-lspconfig {{{
    lua require('configs/lsp')
"   }}}
"
  " nvim-tree {{{
    let g:nvim_tree_update_cwd = 1
    let g:nvim_tree_width = 40
    let g:nvim_tree_disable_netrw = 0
    let g:nvim_tree_hijack_netrw = 0
    nnoremap <silent><C-e> :NvimTreeToggle<CR>
    nnoremap <silent><leader>e :NvimTreeFindFile<CR>
  " }}}

  " compe {{{
    lua require('configs/compe')
  " }}}

  " hop {{{
    lua require('configs/hop')
  " }}}

  " autopairs {{{
    lua require('configs/autopairs')
  " }}}

  " indent-blankline {{{
    lua require('configs/indent-blankline')
    let g:indent_blankline_enabled = v:false
    nnoremap <leader>it :IndentBlanklineToggle<CR>
  " }}}

  " vim-github-link {{{
    nnoremap gcp :GetCommitLink<CR>
  " }}}

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

  " autosave {{{
    let g:auto_save = 1
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
    if filereadable($FZF_DEFAULT_OPTS_FILE)
      let $FZF_DEFAULT_OPTS = system('cat $FZF_DEFAULT_OPTS_FILE')
    end

    let g:fzf_preview_window = []

    if exists('g:fzf_ignore_list')
      let $FZF_IGNORE_LIST = g:fzf_ignore_list
    else
      let g:fzf_ignore_list = $FZF_IGNORE_LIST
    endif

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

    nnoremap <leader>w "zyiw:exe "F ".@z.""<CR>
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>s :BLines<CR>
    nnoremap <leader>bs :Buffers<CR>
    nnoremap <leader>m :Marks<CR>
    nnoremap <leader>gf :GFiles?<CR>
    nnoremap <leader>x :Windows<CR>
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
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &ft !=# 'NvimTree' && &buftype !=# 'terminal' | setlocal relativenumber | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &ft !=# 'NvimTree' && &buftype !=# 'terminal' | setlocal norelativenumber | endif
    augroup END
  endfunction

  function! s:numbers_off()
    set nonumber norelativenumber
    augroup numbers
      autocmd!
    augroup END
  endfunction

  function! OpenPlug(plug) abort
    let without_opts = split(a:plug, ',')[0]
    let normalized_name = substitute(without_opts, "Plug", "", "")
    let normalized_name = substitute(normalized_name, " ", "", "g")
    let normalized_name = substitute(normalized_name, "'", "", "g")
    let plug_name = split(normalized_name, '/')[-1]
    let path_to_plug = s:plugs_path . '/' . plug_name
    execute('e ' . path_to_plug)
    execute('lcd ' . path_to_plug)
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
    execute 'e '.$MYVIMRC
    execute 'lcd %:p:h'
  endfunction

  function! Confl() abort
    execute 'e .nvimrc'
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
  nnoremap <leader>k :bd!<CR>
  nnoremap <leader>c ZZ<CR>

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

  " source configs
  nnoremap S :source $MYVIMRC \| call SourceIfExists(".nvimrc")<CR>

  " exit from terminal mode
  tnoremap jk <C-\><C-n>

  nnoremap <silent> <C-n> :cnext<CR>
  nnoremap <silent> <C-p> :cprevious<CR>
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
      autocmd FileType vim nnoremap <silent> <leader>o :normal vil<CR> :call
        \ OpenPlug(<SID>get_selected_text())<CR>

      autocmd TermOpen * setlocal nonumber norelativenumber

      autocmd TextYankPost * silent! lua vim.highlight.on_yank{timeout=400, on_visual=false}
    augroup END

    augroup Ruby
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

:call <SID>numbers_on()
