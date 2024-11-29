-- Key mapping to easily edit this configuration file
vim.api.nvim_set_keymap('n', '<leader>ev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- General Neovim settings
vim.opt.number = true  -- Enable line numbers

-- Normal mode (use kj instead of Esc to exit)
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })

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

-- Quit all open tabs and windows
vim.api.nvim_set_keymap('n', '<leader>qa', ':qa<CR>', { noremap = true, silent = true })

-- Open a new tab
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- Shortcut to copy the last message to the system clipboard
vim.api.nvim_set_keymap('n', '<leader>my', ':lua vim.fn.setreg("+", vim.fn.execute("messages"))<CR>', { noremap = true, silent = true })

