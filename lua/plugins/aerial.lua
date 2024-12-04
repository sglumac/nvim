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
        icons = {
          Array = "[A]",          -- Use simple characters to represent types
          Boolean = "[B]",
          Class = "[C]",
          Constant = "[CONST]",
          Constructor = "[CTOR]",
          Enum = "[E]",
          EnumMember = "[EM]",
          Event = "[EVT]",
          Field = "[F]",
          File = "[FILE]",
          Function = "[FN]",      -- Use [FN] to represent functions
          Interface = "[IF]",
          Key = "[K]",
          Method = "[M]",         -- Use [M] for methods
          Module = "[MOD]",
          Namespace = "[NS]",
          Null = "[NULL]",
          Number = "[#]",
          Object = "[OBJ]",
          Operator = "[OP]",
          Package = "[PKG]",
          Property = "[P]",
          String = "[S]",
          Struct = "[ST]",
          TypeParameter = "[TP]",
          Variable = "[V]",
        },
        manage_folds = true,
        link_folds_to_tree = true,
        link_tree_to_folds = true,
        nerd_font = false,       -- Disable nerd font to avoid using special icons
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

