return {
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

      vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- Find files
      vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- Live grep
      vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })   -- List buffers
      vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true }) -- Help tags

    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}

