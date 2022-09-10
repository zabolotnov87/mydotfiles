-- Plug 'neovim/nvim-lspconfig'

local lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
  })

  local signs = { Error = "E", Warning = "W", Hint = "H", Info = "I" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.cmd "call SetupLspDiagnosticHighlight()"

  -- Mappings
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<c-]>',      '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', ']e',         '<cmd>lua vim.diagnostic.goto_next({popup_opts = {focusable = false }})<cr>', opts)
  buf_set_keymap('n', '[e',         '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {focusable = false }})<cr>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '=',          '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = vim.g.lsp_servers or {
  'rust_analyzer',
  'gopls',
  'tsserver',
}

for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
