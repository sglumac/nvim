-- Disable warning "Undefined global `vim`"
_G.vim = vim

require("general")

-- Ensure Lazy.nvim is installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

-- Jump to the next diagnostic (warning or error)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Jump to the previous diagnostic (warning or error)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })

-- Set keybinding for applying LSP code actions
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true  -- Use spaces instead of tab characters
vim.opt.softtabstop = 2

-- Set a breakpoint
vim.api.nvim_set_keymap('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })

-- Start or continue debugging
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })

-- Stop debugging
vim.api.nvim_set_keymap('n', '<leader>dq', ':lua require("dap").terminate()<CR>:lua require("dapui").close()<CR>', { noremap = true, silent = true })

-- Step over a function
vim.api.nvim_set_keymap('n', '<leader>n', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })

-- Step into a function
vim.api.nvim_set_keymap('n', '<leader>s', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })

-- Step out of a function
vim.api.nvim_set_keymap('n', '<leader>o', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })

-- Open or close the DAP UI
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dapui")".toggle()<CR>', { noremap = true, silent = true })

