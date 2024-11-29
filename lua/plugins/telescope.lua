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
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}

