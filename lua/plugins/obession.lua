return {
  {
    "tpope/vim-obsession",
    event = "VeryLazy", -- Optional: Load lazily for better startup time
    config = function()
      -- Start or stop tracking the session
      vim.keymap.set("n", "<leader>so", ":Obsession<CR>", { desc = "Start/Stop Obsession (Save Session)" })

      -- Restore the session from Session.vim
      vim.keymap.set("n", "<leader>sr", ":source Session.vim<CR>", { desc = "Restore Session" })
    end,
  },
}
