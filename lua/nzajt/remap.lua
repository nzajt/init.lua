vim.g.mapleader = " "

-- Puts things on one line
vim.keymap.set("n", "J", "mzJ`z")

-- Easy navigation to top and bottom of file
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- And easy way to search for things
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, don't save x to clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- I don't use record so kill it
vim.keymap.set("n", "Q", "<nop>")

-- Formating made easy
vim.keymap.set("n", "<leader>g", vim.lsp.buf.format)

-- easy navigation between buffers
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
