local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
      filter = function(client)
        return client.name == "null-ls"
      end
    end,
  })
end

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'rust_analyzer',
  'rubocop',
  'ruby_lsp',
  'pyright'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  if client.name == "eslint" then
    vim.cmd.LspStop('eslint')
    return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

local enabled_features = {
  "documentHighlights",
  "documentSymbols",
  "foldingRanges",
  "selectionRanges",
  "semanticHighlighting",
  "formatting",
  "codeActions",
}

-- Ruby LSP
lsp.configure('ruby-lsp', {
  cmd = { 'bundle', 'exec', 'ruby-lsp' },
  filetypes = { "ruby", "rakefile" },
  init_options = { enabledFeatures = enabled_features },
  settings = {},
  commands = {
    FormatRuby = {
      function()
        vim.lsp.buf.formatting({
          name = "ruby_lsp",
          async = true,
        })
      end,
      description = "Format using ruby-lsp",
    },
  },
})

-- Autoformat on save

lsp.on_attach(function(client, bufnr)
  lsp_format_on_save(bufnr)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['rust_analyzer'] = { 'rust' },
    ['ruby_ls'] = { 'ruby' },
    ['pyright'] = { 'python' },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.
    -- ['null-ls'] = {'javascript', 'typescript'},
  }
})
