-- Plug 'phaazon/hop.nvim'

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

local function map(...) vim.api.nvim_set_keymap(...) end

map('n', '<leader><leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true})
map('v', '<leader><leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true})
map('n', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true})
map('v', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true})
map('n', '<leader><leader>f', "<cmd>lua require'hop'.hint_char1()<cr>", { silent = true})
map('v', '<leader><leader>f', "<cmd>lua require'hop'.hint_char1()<cr>", { silent = true})
