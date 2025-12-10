" vim:foldmethod=marker:foldminlines=1

" Plugins {{{
  let g:plug_window='new'

  let s:plugs_path='~/.local/share/nvim/plugged'
  call plug#begin(s:plugs_path)

  " wrapper for running tests
  Plug 'janko-m/vim-test'
  " terminal manager for vim-test
  Plug 'kassio/neoterm'
  " easymotion for neovim
  Plug 'phaazon/hop.nvim'
  " delete/change/add parentheses/quotes/tags
  Plug 'tpope/vim-surround'
  " plugin to comment text in and out
  Plug 'b3nj5m1n/kommentary'
  " snippets manager
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
  " lsp
  Plug 'neovim/nvim-lspconfig'
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
  " linting and formatting
  Plug 'dense-analysis/ale'
  " allows to create dirs automatically
  Plug 'DataWraith/auto_mkdir'
  " elignment plugin
  Plug 'junegunn/vim-easy-align'

  " interface to git
  Plug 'tpope/vim-fugitive'

  " the best fuzzy finder
  Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'

  " treesitter-related staff
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  Plug 'vimwiki/vimwiki'

  call plug#end()
" }}}
