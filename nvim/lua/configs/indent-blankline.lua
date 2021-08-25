-- Plug 'lukas-reineke/indent-blankline.nvim'

require("indent_blankline").setup{
  char = "|",
  buftype_exclude = {"terminal", "help"}
}
