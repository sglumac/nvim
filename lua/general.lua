-- Set the leader key to '\'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
  },
})

-- Jump to the next diagnostic (warning or error)
 vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Jump to the previous diagnostic (warning or error)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })


-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true  -- Use spaces instead of tab characters
vim.opt.softtabstop = 2

-- General Neovim settings
vim.opt.number = true  -- Enable line numbers

-- Normal mode (use kj instead of Esc to exit)
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })

-- Repeat the last recorded macro
vim.api.nvim_set_keymap('n', '<leader>r', '@@', { noremap = true, silent = true })

-- Open Neovim configuration
vim.api.nvim_set_keymap('n', '<leader>ev', ':edit ~/.config/nvim/init.lua | lcd ~/.config/nvim<CR>', { noremap = true, silent = true })

-- Copy to system clipboard (<leader>y) and paste from clipboard (<leader>p)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })

-- Save the current buffer
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Save and close the current buffer
vim.api.nvim_set_keymap('n', '<leader>wq', ':wq<CR>', { noremap = true, silent = true })

-- Quit without saving changes
vim.api.nvim_set_keymap('n', '<leader>x', ':q!<CR>', { noremap = true, silent = true })

-- Quit the current window
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Quit all open tabs and windows
vim.api.nvim_set_keymap('n', '<leader>qa', ':qa<CR>', { noremap = true, silent = true })

-- Open a new tab
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- Shortcut to copy the last message to the system clipboard
vim.api.nvim_set_keymap('n', '<leader>my', ':lua vim.fn.setreg("+", vim.fn.execute("messages"))<CR>', { noremap = true, silent = true })

