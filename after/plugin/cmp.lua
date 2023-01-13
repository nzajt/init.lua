require('cmp').setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 2 },
    { name = 'buffer',
      keyword_length = 2,
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end
    },
  },
})
