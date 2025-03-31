return {
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup({
      layout = {
        default_direction = "right",
        max_width = math.floor(vim.o.columns * 0.5),
      },
      enter_on_toggle = true,    -- focus aerial on toggle
      autojump = true,           -- immediately jump to symbol on move
      close_on_select = true,    -- close the Aerial window after selecting a symbol
    })
    -- Optional: Keymaps
    vim.keymap.set("n", "<leader>ar", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial outline" })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional but recommended
    "nvim-lspconfig"                   -- required
  }
}

