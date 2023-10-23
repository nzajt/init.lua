local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>s', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.8 }
      -- other layout configuration here
    },
    file_ignore_patterns = { '^assets/' }
    -- other defaults configuration here
  },
  -- other configuration values here
})
