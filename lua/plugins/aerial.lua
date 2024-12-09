return {
  {
  'stevearc/aerial.nvim',
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
      require('aerial').setup({
        backends = { "lsp", "treesitter" },
        layout = {
          max_width = { 40, 0.4 },
          width = nil,
          min_width = 20,
          default_direction = "right",
          placement = "window",
        },
        show_guides = true,
        filter_kind = false,
        manage_folds = true,
        link_folds_to_tree = true,
        link_tree_to_folds = true,
        nerd_font = true,
        attach_mode = "global",
      })

-- Function to toggle and immediately focus aerial
function ToggleAndFocusAerial()
  require('aerial').toggle()
  local aerial_win_id = require('aerial.util').get_aerial_win()
  if aerial_win_id then
    vim.api.nvim_set_current_win(aerial_win_id)
  end
end

-- Key mapping to toggle aerial and focus on it
vim.api.nvim_set_keymap('n', '<leader>a', ':lua ToggleAndFocusAerial()<CR>', { noremap = true, silent = true })
    end
  }
}

