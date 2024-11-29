-- Disable warning "Undefined global `vim`"
_G.vim = vim

-- Set the leader key to '\'
vim.g.mapleader = "\\"

-- Key mapping to easily edit this configuration file
vim.api.nvim_set_keymap('n', '<leader>ev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- General Neovim settings
vim.opt.number = true  -- Enable line numbers

-- Normal mode (use kj instead of Esc to exit)
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })

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

require('lazy').setup({
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'lua_ls' },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('lspconfig').clangd.setup{}
      require('lspconfig').lua_ls.setup{}
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap.automatic_setup")(config)
          end,
        },
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-w>'] = cmp.mapping.scroll_docs(-4),
          ['<C-s>'] = cmp.mapping.scroll_docs(4),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'cpp', 'lua', 'python' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = '> ',
          selection_caret = '> ',
          path_display = { 'smart' },
          layout_config = {
            horizontal = { mirror = false },
            vertical = { mirror = false },
          },
          file_ignore_patterns = { 'node_modules', '%.git/' },
        },
      })
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      -- Set up LLDB Debug Adapter
      dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode',  -- Make sure lldb-vscode is installed and this points to the correct path
        name = 'lldb',
      }

      -- Debug Configuration for C++ and C files
      dap.configurations.cpp = {
        {
          name = 'Launch C++ Program',
          type = 'lldb',           -- Matches the adapter name defined above
          request = 'launch',      -- Launch mode
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',  -- Current directory where the program will run
          stopOnEntry = false,         -- Whether to stop at the entry point of the program
          args = {},                   -- Command-line arguments to the program
          runInTerminal = false,
        },
      }

      -- Reuse the same configuration for C files
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
})

-- Key mappings for Telescope commands
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- Find files
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- Live grep
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })   -- List buffers
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true }) -- Help tags

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

-- Shortcut to copy the last message to the system clipboard
vim.api.nvim_set_keymap('n', '<leader>my', ':lua vim.fn.setreg("+", vim.fn.execute("messages"))<CR>', { noremap = true, silent = true })

