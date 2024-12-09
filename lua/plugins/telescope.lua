return {
  {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-tree/nvim-web-devicons'} },
    config = function()
      require('telescope').setup{
        defaults = {
          mappings = {
            i = { -- Insert mode mappings
              ["<C-j>"] = require('telescope.actions').move_selection_next, -- Move down
              ["<C-k>"] = require('telescope.actions').move_selection_previous, -- Move up
            },
            n = { -- Normal mode mappings
              ["<C-j>"] = require('telescope.actions').move_selection_next, -- Move down
              ["<C-k>"] = require('telescope.actions').move_selection_previous, -- Move up
            },
          },
          prompt_prefix = ": ",
          selection_caret = "> ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/" },
          winblend = 0,
          border = {},
          color_devicons = false,
        },
        pickers = {
          find_files = {
            theme = "dropdown",
          },
        },
      }
      require('telescope').load_extension('fzf')

      vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- Find files
      vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- Live grep
      vim.api.nvim_set_keymap('v', '<leader>fg', ':lua require("telescope.builtin").live_grep({ default_text = vim.fn.getreg("\"") })<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })   -- List buffers
      vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true }) -- Help tags
      vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<CR>', { noremap = true, silent = true }) -- Grep for word under cursor
      vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>', { noremap = true, silent = true }) -- Grep for word under cursor

    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}

